import 'package:flutter/material.dart';

import '../../page/profile.dart';
import '../profile_image.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String date;
  final String imageUrl;
  final String id;

  const UserInfo({
    Key? key,
    required this.id,
    required this.name,
    required this.date,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 141, 133, 137).withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          GestureDetector(
<<<<<<< HEAD
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userId: id,
                    ),
                  ),
                );
              },
=======
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage())),
>>>>>>> ccf8b2c (:boom: add new feature)
              child: ProfileImage(imageUrl: imageUrl, size: 45)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: const TextStyle(
                  color: Color(0xFFE1DBDB),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
