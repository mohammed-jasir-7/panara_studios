part of 'feeds_bloc.dart';

abstract class FeedsEvent extends Equatable {
  const FeedsEvent();
}

class AddFeedEvent extends FeedsEvent {
  final FileDetils file;
const AddFeedEvent({required this.file});
 @override
  List<Object?> get props => [file];
}

class FetchfeedEvent extends FeedsEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

}
