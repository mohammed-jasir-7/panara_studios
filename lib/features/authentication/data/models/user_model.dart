import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String name,
    required String email,
    required bool isNewUser,
    required String uid,
    required String photo,
  }) : super(
            email: email,
            isNewUser: isNewUser,
            name: name,
            photo: photo,
            uid: uid);
  Map<String , dynamic> toJson(){
    return { 'email': email,
            "isNewUser": isNewUser,
            'name': name,
            'photo': photo,
            'uid': uid};

  }
}
