import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/features/feeds/domain/entities/post_entity.dart';
import 'package:panara_studios/features/feeds/domain/repositories/feed_repository.dart';

@Injectable()
class FetchPosts{
 final FeedRepository repository;

  FetchPosts({required this.repository});

  
  Future<Either<Failure, List<PostEntity>>> call()async{
    return await repository.fetchFeed();
  }
}