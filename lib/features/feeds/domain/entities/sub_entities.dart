import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';

class CommentEntity {
final String comment;
final String id;
final List<UserEntity> user;

  CommentEntity({required this.comment, required this.id, required this.user});
}
 class LikeEntity{
  final List<UserEntity> user;

  LikeEntity({required this.user});
 }