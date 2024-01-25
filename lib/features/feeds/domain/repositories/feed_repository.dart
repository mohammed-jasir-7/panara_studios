import 'package:dartz/dartz.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/core/params/params.dart';
import 'package:panara_studios/features/feeds/domain/entities/post_entity.dart';
import 'package:panara_studios/features/feeds/domain/entities/sub_entities.dart';

abstract class FeedRepository{
  ///fetch feed from api
  ///it return list of post
Future<Either<Failure, List<PostEntity>>> fetchFeed();
///add post
///return that which post you add then easly update feeds section. it helps to optimze perfomance
Future<Either<Failure, PostEntity>> addpost({required PostParams post});
///add post
///return that which post you add then easly update feeds section. it helps to optimze perfomance
Future<Either<Failure, PostEntity>> deletePost({required String id});
///add post
///return that which post you add then easly update feeds section. it helps to optimze perfomance
Future<Either<Failure, CommentEntity>> addComment({required String postId,required CommentEntity comment});
/// for add like
addLike({required LikeEntity likeDetails});

}