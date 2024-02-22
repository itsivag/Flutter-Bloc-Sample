import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc_sample/features/posts/models/posts_data_ui_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sample/features/posts/repos/PostRepo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostsAddEvent>(postsAddEvent);
  }

  Future<FutureOr<void>> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    //emit a loading state
    emit(PostsFetchLoadingState());

    //get posts from repo
    List<PostDataUiModel> posts = await PostRepo.fetchPost();

    //emit a post fetching success event
    emit(PostsFetchSuccessfulState(posts: posts));

    //emit a error
    if (posts.isEmpty) {
      emit(PostsFetchErrorState());
    }
  }

  Future<FutureOr<void>> postsAddEvent(
      PostsAddEvent event, Emitter<PostsState> emit) async {
    bool res = await PostRepo.addPost();

    res ? emit(PostAdditionSuccessState()) : emit(PostAdditionErrorState());
  }
}
