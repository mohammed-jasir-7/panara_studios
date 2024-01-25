import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/widgets/snackbar_global.dart';
import 'package:panara_studios/features/authentication/domain/usecases/google_signin.dart';
import 'package:panara_studios/features/authentication/presentation/pages/signing_page.dart';
import 'package:panara_studios/main.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@Injectable()
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GoogleSignin googleSignin;
  AuthenticationBloc(this.googleSignin) : super(AuthenticationInitial()) {
 

    on<SignOutEvent>((event, emit) {
      emit(LoadingState());
      Navigator.pushAndRemoveUntil(
          navigatorState.currentContext!,
          MaterialPageRoute(
            builder: (context) => const SiginingScreen(),
          ),
          (route) => false);
      emit(SignOutstate());
    });
    on<SignInEvent>((event, emit) async {
      emit(LoadingState());
      var data = googleSignin.getCurrentUser();
      if (data.isRight()) {
        emit(SignInstate());
      } else {
        var result = await googleSignin();
        result.fold((l) {
          ScaffoldMessenger.of(navigatorState.currentContext!)
              .showSnackBar(snackBar(content: l.errorMessage));
          emit(ErrorState());
        }, (r) {
          emit(SignInstate());
        });
      }
    });
  }
}
