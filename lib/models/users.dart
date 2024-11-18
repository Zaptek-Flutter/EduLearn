// user_model.dart
class UserModel {
  final String uid;
  final String username;
  final String email;
  final String profilePictureUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
  });

  // Convert a UserModel into a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Create a UserModel from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      profilePictureUrl: map['profilePictureUrl'],
    );
  }
}
