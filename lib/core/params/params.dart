class NoParams {}


class PostParams {
  
  final String filetype;
  final double fileRatio;
  final String file;
  final UserParams user;
  final String time;

  final CommentParams? comment;


  PostParams(
      {
      required this.filetype,
      required this.fileRatio,
      required this.file,
      required this.user,
      required this.time,
    
       this.comment,
     
       });
}

class CommentParams {
final String comment;
final String id;
final List<UserParams> user;

  CommentParams({required this.comment, required this.id, required this.user});
}
 class LikeParams{
  final List<UserParams> user;

  LikeParams({required this.user});
 }

 class UserParams {
  final String name;
  final String uid;
  final String email;
  final String photo;
 

  UserParams({required this.name, required this.uid, required this.email, required this.photo,});

  
}