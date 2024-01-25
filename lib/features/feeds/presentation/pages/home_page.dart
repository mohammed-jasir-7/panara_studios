
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:panara_studios/core/constants/colors.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/core/functions/local_file_access.dart';
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
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
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
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                initialItemCount: 150,
                itemBuilder: (context, index, animation) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50.w,
                          width: 375.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20.r,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        'Name',
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
                        Container(
                          width: 375.w,
                          height: 300,
                          color: Colors.grey,
                        ),
                        Container(
                          height: 50.w,
                          width: 375.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border)),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        'Name',
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
                             result?.fold((l) => null, (r) => context.read<FeedsBloc>().add(AddFeedEvent(file: r)));
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
