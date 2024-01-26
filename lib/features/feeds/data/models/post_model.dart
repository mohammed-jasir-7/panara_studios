import 'package:panara_studios/features/feeds/domain/entities/post_entity.dart';
import 'package:panara_studios/features/feeds/domain/entities/sub_entities.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.id,
      required super.filetype,
      required super.fileRatio,
      required super.time,
      required super.fileUrl,
      required super.dp,
      required super.email,
      required super.name,
      required super.uid,
      super.comment,
      required super.likeCount,
      super.like});
  factory PostModel.fromjson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        filetype: json['type'],
        fileRatio: json['ratio'],
        time: json['time'],
        fileUrl: json['photo'],
        dp: json['dp'],
        email: json['email'],
        name: json['name'],
        uid: json['uid'],
        likeCount: json['likeCount']);
  }
}

class CommentModel extends CommentEntity {
  CommentModel(
      {required super.comment, required super.id, required super.user});
}

class LikeModel extends LikeEntity {
  LikeModel({required super.user});
}
