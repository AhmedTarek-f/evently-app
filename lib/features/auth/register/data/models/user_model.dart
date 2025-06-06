import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.gender,
    this.photoUrl = "",
    required this.favoriteEvents,
  });
  final String id;
  final String userName;
  final String email;
  final String? gender;
  final String? photoUrl;
  List<String> favoriteEvents;

  static UserModel empty() => UserModel(
        id: "",
        userName: "",
        email: "",
        gender: "",
        photoUrl: "",
        favoriteEvents: [],
      );

  Map<String, dynamic> toFireStore() {
    return {
      "Id": id,
      "UserName": userName,
      "Email": email,
      "Gender": gender,
      "ProfilePic": photoUrl,
      "FavoriteEvents": favoriteEvents,
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
        favoriteEvents: List<String>.from(data["FavoriteEvents"] ?? <String>[]),
      );
    } else {
      return empty();
    }
  }
}
