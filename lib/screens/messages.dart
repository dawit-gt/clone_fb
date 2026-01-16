import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  final List<Map<String, String>> mockMessages = const [
    {
      'name': 'Alice',
      'message': 'Hey — how are you?',
      'avatar': 'assets/images/new_pages/photo1.jpg'
    },
    {
      'name': 'Bob',
      'message': "Let's catch up later!",
      'avatar': 'assets/images/new_pages/photo2.jpg'
    },
    {
      'name': 'Cleo',
      'message': 'Awesome photo!',
      'avatar': 'assets/images/new_pages/photo3.jpg'
    },
    {
      'name': 'Dan',
      'message': 'Can you review this?',
      'avatar': 'assets/images/new_pages/photo4.jpg'
    },
    {
      'name': 'Eve',
      'message': 'Thanks!',
      'avatar': 'assets/images/new_pages/photo5.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: mockMessages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = mockMessages[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(item['avatar']!),
            ),
            title: Text(item['name']!),
            subtitle: Text(item['message']!),
            onTap: () {
              // Placeholder action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Open chat with ${item['name']}')),
              );
            },
          );
        },
      ),
    );
  }
}
