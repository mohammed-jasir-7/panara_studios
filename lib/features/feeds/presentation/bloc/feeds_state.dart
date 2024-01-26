part of 'feeds_bloc.dart';

abstract class FeedsState extends Equatable {
  const FeedsState();  


}
class FeedsInitial extends FeedsState {
  @override
  
  List<Object?> get props => [];
}
class FeedLoadingState extends FeedsState{
  @override
  List<Object?> get props =>[];

}
class FeedErrorState extends FeedsState{
  @override
  List<Object?> get props => [];

}
class PostState extends FeedsState{
  final List<PostEntity> posts;

  const PostState({required this.posts});
  @override
  List<Object?> get props => [posts];
  
}
