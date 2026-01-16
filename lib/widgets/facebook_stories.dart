import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/user_model.dart';

class FacebookStories extends StatelessWidget {
  final List<UserModel> users;

  const FacebookStories({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length + 1, // +1 for "Add Story"
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _AddStoryCard();
          }
          return _StoryCard(user: users[index - 1]);
        },
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final UserModel user;

  const _StoryCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(user.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child:ElevatedButton(
              onPressed: (){
                context.go('/profile');
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(user.image),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              user.firstName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _AddStoryCard extends StatelessWidget {
  const _AddStoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.go('/profile');
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/200?u=myprofile'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle, color: Colors.blue),
                SizedBox(height: 4),
                Text("Create Story", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
