import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.isNewUser,
    required super.uid,
    required super.photo,
  });
  Map<String , dynamic> toJson(){
    return { 'email': email,
            "isNewUser": isNewUser,
            'name': name,
            'photo': photo,
            'uid': uid};

  }
}
