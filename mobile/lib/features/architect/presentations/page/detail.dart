import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domains/entities/post.dart';
import '../../domains/entities/user.dart';
import '../widget/post/post_info.dart';
import '../widget/post/react.dart';

class DetailPage extends StatelessWidget {
  final User user;
  const DetailPage({
    required this.user,
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  String capitalizeAll(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.split(' ').map((e) => capitalize(e)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 435,
                          child: Image.network(post.image, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: PostInfo(
                            id: post.id,
                            name:
                                '${capitalize(post.firstName)} ${capitalize(post.lastName)}',
                            date: DateFormat('MMM d y').format(post.date),
                            imageUrl: post.userImage,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Row(
                            children: [
                              React(
                                text: post.like.toString(),
                                isColor: post.isLiked,
                                icon: Icon(Icons.favorite,
                                    size: 35,
                                    color: post.isLiked
                                        ? const Color.fromARGB(255, 230, 57, 57)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255)),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 20),
                              React(
                                text: post.clone.toString(),
                                isColor: post.isCloned,
                                icon: Icon(Icons.cyclone,
                                    size: 35,
                                    color: post.isCloned
                                        ? const Color.fromARGB(255, 230, 57, 57)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255)),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...post.tags.map((e) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 38,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8E0E4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text(capitalizeAll(e))),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      capitalizeAll(post.title),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      post.content,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.25,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
