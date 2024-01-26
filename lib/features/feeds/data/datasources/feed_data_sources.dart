import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/exceptions.dart';
import 'package:panara_studios/core/params/params.dart';
import 'package:panara_studios/features/feeds/data/models/post_model.dart';

abstract class FeedDataSources {
  Future<PostModel>addfeedToDB(PostParams params);
  Future<List<PostModel>>fetchFeedFromDB();
}

@Injectable(as: FeedDataSources)
class FeedDataSourcesImpl extends FeedDataSources {
  @override
 Future<PostModel> addfeedToDB(PostParams params) async {
    // add image to database
    var root = FirebaseStorage.instance.ref();
    var imageDir = root.child('post');
    var upload =
        imageDir.child(DateTime.now().millisecondsSinceEpoch.toString());

    try {
    await upload.putFile(File(params.file));
    } catch (e) {
      throw ServerException();
    }
    try {
      
         String loc = await upload.getDownloadURL();
    var result = await FirebaseFirestore.instance
        .collection('post')
        .add({'uid': params.user.uid});
    await result.set({
      'id':result.id,
      'type': params.filetype,
      'photo': loc,
      'ratio': params.fileRatio,
      'time': params.time,
      'name': params.user.name,
      'dp': params.user.photo,
      'uid': params.user.uid,
      'email': params.user.email,
      'likeCount':0,
    });
    return 
    PostModel(
        id: result.id,
        filetype: params.filetype,
        fileRatio: params.fileRatio,
        time: params.time,
        fileUrl: loc,
        likeCount: 0,
        dp: params.user.photo,
        email: params.user.email,
        name: params.user.name,
        uid: params.user.uid);

      
      
      
    } catch (e) {
      throw ServerException();
    }

   
  }
  
  @override
  Future<List<PostModel>> fetchFeedFromDB()async {
   var result = await FirebaseFirestore.instance
        .collection('post').get();
        List<PostModel> posts=[];
        for (var element in result.docs) {
        var data=  element.data();
        posts.add(PostModel.fromjson(data))
        ;
        }
        
   return posts;
  }
}
