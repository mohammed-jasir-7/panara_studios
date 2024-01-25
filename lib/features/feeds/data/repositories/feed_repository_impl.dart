import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/connection/network_info.dart';
import 'package:panara_studios/core/errors/exceptions.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/core/params/params.dart';
import 'package:panara_studios/features/feeds/data/datasources/feed_data_sources.dart';
import 'package:panara_studios/features/feeds/domain/entities/post_entity.dart';
import 'package:panara_studios/features/feeds/domain/entities/sub_entities.dart';
import 'package:panara_studios/features/feeds/domain/repositories/feed_repository.dart';

@Injectable(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSources dataSources;
   final NetworkInfo networkInfo;

  FeedRepositoryImpl({required this.dataSources, required this.networkInfo});

  
  @override
  Future<Either<Failure, CommentEntity>> addComment(
      {required String postId, required CommentEntity comment}) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  addLike({required LikeEntity likeDetails}) {
    // TODO: implement addLike
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> addpost(
      {required PostParams post}) async {
        if (await networkInfo.isConnected!) {
            try {
      return right(await dataSources.addfeedToDB(post));
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'image upload failed'));
    }
        }else{
           return left(InternetFailure(errorMessage: 'No internet access'));
        }
  
  }

  @override
  Future<Either<Failure, PostEntity>> deletePost({required String id}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> fetchFeed() {
    // TODO: implement fetchFeed
    throw UnimplementedError();
  }
}
