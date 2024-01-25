import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(width: double.infinity,height: double.infinity,
        child: Center(child: Lottie.asset('assets/lottie/loading.json',width: 100.w),),),
      ),);
  }
}