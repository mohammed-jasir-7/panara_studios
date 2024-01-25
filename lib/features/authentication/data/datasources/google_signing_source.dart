import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/exceptions.dart';
import 'package:panara_studios/features/authentication/data/models/user_model.dart';

abstract class GoogleSignDataSource {
  Future<UserModel> signInWithGoogle();
  Future saveToDatabase({required UserModel user});
  UserModel? getCurrentUserFromDb();
}

@Injectable(as: GoogleSignDataSource)
class GoogleSignDataSourceImpl extends GoogleSignDataSource {
  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      //Starts the interactive sign-in process.
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.signOut();

        await GoogleSignIn().disconnect();

        await FirebaseFirestore.instance.clearPersistence();
      }
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        var user = await FirebaseAuth.instance.signInWithCredential(credential);
        return UserModel(
            name: user.user?.displayName ?? '',
            email: user.user?.email ?? '',
            isNewUser: user.additionalUserInfo?.isNewUser ?? false,
            uid: user.user?.uid ?? '',
            photo: user.user?.photoURL ?? '');
      } else {
        throw ClientSideException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future saveToDatabase({required UserModel user}) async {
    var fireStore = FirebaseFirestore.instance;
    try {
      var result =
          await fireStore.collection('Users').doc(user.uid).set(user.toJson());
      log('ll'.toString());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  getCurrentUserFromDb() {
    var data = FirebaseAuth.instance.currentUser;
    if (data != null) {
      return UserModel(
          name: data.displayName ?? '',
          email: data.email ?? '',
          isNewUser: false,
          uid: data.uid,
          photo: data.photoURL ?? '');
    } else {
      return null;
    }
  }
}
