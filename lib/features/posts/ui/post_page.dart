import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postBloc = PostsBloc();

  @override
  void initState() {
    postBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Posts Page'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            postBloc.add(PostsAddEvent());
          },
          child: const Icon(Icons.add)),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchSuccessfulState:
              final successState = state as PostsFetchSuccessfulState;
              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.posts[index].title),
                          Text(successState.posts[index].body),
                        ],
                      ),
                    );
                  });

            case PostsFetchLoadingState:
              return const Center(child: CircularProgressIndicator());

            case PostAdditionSuccessState:
              return const Center(
                child: Text('Data Posted!'),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
