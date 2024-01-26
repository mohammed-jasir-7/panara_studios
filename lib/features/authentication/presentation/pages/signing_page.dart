import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_studios/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:panara_studios/features/feeds/presentation/pages/home_page.dart';

class SiginingScreen extends StatefulWidget {
  const SiginingScreen({super.key});

  @override
  State<SiginingScreen> createState() => _SiginingScreenState();
}

class _SiginingScreenState extends State<SiginingScreen> {
  double trun = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      context.read<AuthenticationBloc>().add(InitalAuthenticationEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 200.w,
                child: Image.asset(
                  'assets/logo/panara.png',
                )),
            Column(
              children: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                  if (state is SignInstate) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false);
                  }
                  },
                  child: InkWell(
                    onTap: () {
                      context.read<AuthenticationBloc>().add(SignInEvent());
                      setState(() {
                        trun += 1 / 4;
                      });
                    
                    },
                    child: AnimatedRotation(
                      turns: trun,
                      duration: const Duration(milliseconds: 300),
                      child: CircleAvatar(
                          radius: 100.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              const AssetImage('assets/logo/google_logo.png')),
                    ),
                  ),
                ),
                Text(
                  'Sign in with google',
                  style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
