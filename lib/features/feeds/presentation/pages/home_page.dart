import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          onPressed: () {
            setState(() {
              isPlaying = !isPlaying;
              isPlaying
                  ? _animationController?.forward()
                  : _animationController?.reverse();
            });
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
                              mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                                            
                                                              children: [
                               SizedBox(
                                width: 12.w,
                              ),
                            IconButton(onPressed: () {
                              
                            }, icon: const Icon(Icons.favorite_border)),
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
}
