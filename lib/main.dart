import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:panara_studios/core/widgets/loading_screen.dart';
import 'package:panara_studios/features/authentication/presentation/bloc/authentication_bloc.dart';

import 'package:panara_studios/features/authentication/presentation/pages/signing_page.dart';
import 'package:panara_studios/features/feeds/presentation/bloc/feeds_bloc.dart';
import 'package:panara_studios/features/feeds/presentation/pages/home_page.dart';
import 'package:panara_studios/injectable.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>(),
        
        ),
        BlocProvider(
          create: (context) => getIt<FeedsBloc>(),
        
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorState,
          title: 'Panara',
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is SignOutstate) {
                return const SiginingScreen();
              } else if (state is SignInstate) {
                return const HomeScreen();
              } else if (state is ErrorState) {
                return const SiginingScreen();
              } else if (state is LoadingState) {
                return const LoadingScreen();
              } else {
                return const SiginingScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
