import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/functions/get_current_user.dart';
import 'package:panara_studios/core/functions/local_file_access.dart';
import 'package:panara_studios/core/params/params.dart';
import 'package:panara_studios/features/feeds/domain/usecases/add_post.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';

@Injectable()
class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final AddPost addPost;
  FeedsBloc(this.addPost) : super(FeedsInitial()) {
    on<AddFeedEvent>((event, emit) async {
      var size =
          await decodeImageFromList(File(event.file.path).readAsBytesSync());
      var ratio = size.width / size.height;
      var user = getCurrentuser();
      if (user != null) {
       var params= PostParams(
        
          filetype: 'image',
          fileRatio: ratio,
          file: event.file.path,
          user: UserParams(
            name: user.displayName ?? '',
            uid: user.uid,
            email: user.email ?? '',
            photo: user.photoURL ?? '',
          ),
          time: DateTime.now().toString(),
        );
      await  addPost(post: params);
      }
    });
  }
}
