import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:panara_studios/core/constants/colors.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/core/functions/local_file_access.dart';
import 'package:panara_studios/core/widgets/loading_screen.dart';
import 'package:panara_studios/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:panara_studios/features/authentication/presentation/pages/signing_page.dart';
import 'package:panara_studios/features/feeds/presentation/bloc/feeds_bloc.dart';
import 'package:panara_studios/injectable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final GlobalKey<AnimatedListState> key=GlobalKey();
  bool isPlaying = false;
   bool isLiked=false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    context.read<FeedsBloc>().add(FetchfeedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              isPlaying = !isPlaying;
              isPlaying
                  ? _animationController?.forward()
                  : _animationController?.reverse();
            });
            await fileModalBottomSheet(context);
          },
          child: AnimatedIcon(
              icon: AnimatedIcons.close_menu, progress: _animationController!)),
      appBar: AppBar(
        title: Image.asset(
          'assets/logo/panara.png',
          width: 150.w,
        ),
        actions: [Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: IconButton( icon: const Icon(Icons.power_settings_new_rounded,color: Colors.red),onPressed: ()async {
          
              await FirebaseAuth.instance.signOut();
   await GoogleSignIn().disconnect();
   

        //await FirebaseFirestore.instance.clearPersistence();
   await      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SiginingScreen(),), (route) => false);
     
      
            
          },),
        )],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FeedsBloc, FeedsState>(
                builder: (context, state) {
                  if (state is FeedLoadingState) {
                    return const LoadingScreen();
                  }else if(state is FeedErrorState){
                    return const Text('Error');
                  }else if(state is PostState){
                  if (state.posts.isNotEmpty) {
                      return ListView.builder(
key: key,

                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      log("$index   ${state.posts.length}");
                     
                      return Padding(
                        key: ValueKey(state.posts[index].id),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.w,
                              width: 375.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage( state.posts[index].dp,),
                                        radius: 20.r,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            state.posts[index].name,
                                            style: GoogleFonts.roboto(),
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_vert_rounded))
                                ],
                              ),
                            ),
                           AspectRatio(aspectRatio:  state.posts[index].fileRatio,child: Image.network( state.posts[index].fileUrl),),
                            Container(
                              height: 50.w,
                              width: 375.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                          
                                            key.currentState?.removeItem(1, (context, animation) => const Text('data'));
                                            
                                          },
                                          // ignore: dead_code
                                          icon: Icon(isLiked?Icons.favorite:
                                              Icons.favorite_border,)),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      SizedBox(
                                          width: 50.w,
                                          child: Text(
                                             '${state.posts[index].likeCount.toString()} Likes',
                                            style: GoogleFonts.roboto(),
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.comment))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  }else{
                    return const Text('empty');
                  }
                  
                  }else{
                    return const Text('data');
                  }
                
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  fileModalBottomSheet(context) async {
    ValueNotifier<bool> isSelected = ValueNotifier(false);
    dartz.Either<Failure, FileDetils>? result;
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(14.w),
            child: SizedBox(
                width: 360.w,
                child: ValueListenableBuilder(
                    valueListenable: isSelected,
                    builder: (context, value, _) {
                      if (value) {
                        return IconButton(
                            onPressed: () {
                              result?.fold(
                                  (l) => null,
                                  (r) => context
                                      .read<FeedsBloc>()
                                      .add(AddFeedEvent(file: r)));
                            },
                            icon: Icon(
                              Icons.send,
                              color: sendIcon,
                            ));
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () async {
                                result =
                                    await getIt<LocalFileAccess>().pickImage();
                                if (result!.isRight()) {
                                  isSelected.value = true;
                                }
                              },
                              child: SizedBox(
                                  width: 120.w,
                                  child: LottieBuilder.asset(
                                      'assets/lottie/image.json',
                                      width: 100.w))),
                          LottieBuilder.asset(
                            'assets/lottie/video.json',
                            width: 100.w,
                          )
                        ],
                      );
                    })),
          );
        });
  }
}
