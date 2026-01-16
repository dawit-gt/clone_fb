class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String image;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
    );
  }
}
