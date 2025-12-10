import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostLoadRequested extends PostEvent {
  final int postId;

  const PostLoadRequested(this.postId);

  @override
  List<Object> get props => [postId];
}

