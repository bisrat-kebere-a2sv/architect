import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/widget/gallery_item.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:architect/injection_container.dart';

import '../../domains/entities/user.dart';
import '../widget/custom_bottom_navigation.dart';

class BookMark extends StatelessWidget {
  final User user;

  const BookMark({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>()
          ..add(
            ViewsPosts(userId: user.id),
          ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "My Gallery",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Capturing moment of Ai",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Setting(
                                user: user,
                              ),
                            ),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(File(user.image)),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: BlocBuilder<PostBloc, PostState>(
                          builder: (context, state) {
                            if (state is PostInitial || state is PostLoading) {
                              return const SizedBox(
                                height: 550,
                                child: LoadingIndicator(),
                              );
                            } else if (state is PostsViewsLoaded) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    (state.posts.length / 2)
                                                        .ceil();
                                                i++)
                                              if (i % 2 == 0)
                                                GalleryItem(
                                                  user: user,
                                                  half: false,
                                                  post: state.posts[i],
                                                )
                                              else
                                                GalleryItem(
                                                  user: user,
                                                  half: true,
                                                  post: state.posts[i],
                                                ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            for (int i =
                                                    (state.posts.length / 2)
                                                        .ceil();
                                                i < state.posts.length;
                                                i++)
                                              if (i % 2 == 0)
                                                GalleryItem(
                                                  user: user,
                                                  half: true,
                                                  post: state.posts[i],
                                                )
                                              else
                                                GalleryItem(
                                                  user: user,
                                                  half: false,
                                                  post: state.posts[i],
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else if (state is PostError) {
                              return const SizedBox(
                                height: 550,
                                child: Text('Error loading user posts'),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 40,
                right: 40,
                child: CustomBottomNavigation(
                  user: user,
                  currentNav: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
