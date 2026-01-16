import 'package:flutter/material.dart';
import '../models/user_model.dart';

class PostCard extends StatelessWidget {
  final UserModel user;
  final String text;
  final String? image;

  const PostCard({
    super.key,
    required this.user,
    required this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Just now'),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
          if (image != null)
            Image.network(image!, width: double.infinity, fit: BoxFit.cover),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [Text('Like'), Text('Comment'), Text('Share')],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
 