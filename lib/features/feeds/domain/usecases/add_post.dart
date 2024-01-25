import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/core/params/params.dart';
import 'package:panara_studios/features/feeds/domain/entities/post_entity.dart';
import 'package:panara_studios/features/feeds/domain/repositories/feed_repository.dart';
@Injectable()
class AddPost{
 final FeedRepository repository;

  AddPost({required this.repository});
  Future<Either<Failure, PostEntity>> call({required PostParams post})async{
    return await repository.addpost(post: post);
  }
}