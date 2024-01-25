import 'package:panara_studios/features/feeds/domain/entities/sub_entities.dart';

class PostEntity {
  final String id;
  final String filetype;
  final double fileRatio;

 
  final String time;
  final String fileUrl;
  final String dp;
  final String email;
  final String name;
  final String uid;
  final CommentEntity? comment;
  final int likeCount;
  final LikeEntity? like;

  PostEntity(
      {required this.id,
      required this.filetype,
      required this.fileRatio,
      
      required this.time,
      required this.fileUrl,
      required this.dp,
      required this.email,
      required this.name,
      required this.uid,
       this.comment,
      required this.likeCount,
     this.like});
}
