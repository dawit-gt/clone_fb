import 'package:flutter/material.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Top Row: Avatar + Input
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/40?u=myprofile'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Open new post screen
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f2f5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        "What's on your mind?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1.0, color: Color(0xffced0d4)),

            // Bottom Row: Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _PostActionButton(
                  icon: Icons.videocam,
                  iconColor: Colors.red,
                  label: "Live Video",
                ),
                _PostActionButton(
                  icon: Icons.photo_library,
                  iconColor: Colors.green,
                  label: "Photo/Video",
                ),
                _PostActionButton(
                  icon: Icons.emoji_emotions,
                  iconColor: Colors.amber,
                  label: "Feeling/Activity",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _PostActionButton({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black54,
      ),
      onPressed: () {},
      icon: Icon(icon, color: iconColor),
      label: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}
