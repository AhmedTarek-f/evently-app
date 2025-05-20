import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.gender,
    this.photoUrl = "",
  });
  final String id;
  final String userName;
  final String email;
  final String? gender;
  final String? photoUrl;

  static UserModel empty() => const UserModel(
        id: "",
        userName: "",
        email: "",
        gender: "",
        photoUrl: "",
      );

  Map<String, dynamic> toFireStore() {
    return {
      "Id": id,
      "UserName": userName,
      "Email": email,
      "Gender": gender,
      "ProfilePic": photoUrl
    };
  }

  factory UserModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data != null) {
      return UserModel(
        id: data["Id"] as String,
        userName: data["UserName"] as String,
        email: data["Email"] as String,
        gender: data["Gender"] as String?,
        photoUrl: data["ProfilePic"] as String?,
      );
    } else {
      return empty();
    }
  }
}
