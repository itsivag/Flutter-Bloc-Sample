part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;

  PostsFetchSuccessfulState({required this.posts});
}

class PostsFetchErrorState extends PostsState {}

class PostsFetchLoadingState extends PostsState {}

class PostAdditionSuccessState extends PostActionState {}

class PostAdditionErrorState extends PostActionState {}
