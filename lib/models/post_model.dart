class PostModel {
  final int id;
  final int userId;
  final String body;
  final List<String> tags;

  PostModel({
    required this.id,
    required this.userId,
    required this.body,
    required this.tags,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      body: json['body'],
      tags: List<String>.from(json['tags']),
    );
  }
}
