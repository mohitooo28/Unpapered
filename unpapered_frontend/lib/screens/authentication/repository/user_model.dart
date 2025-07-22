import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;

  // Constructor for UserModel
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  // Static function to create an empty user model
  static UserModel empty() => UserModel(id: '', userName: '', email: '');

  // Convert model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'Username': userName,
      'Email': email,
    };
  }

  //Method to create UserModel from Firebase document
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          userName: data['Username'] ?? '',
          email: data['Email'] ?? '');
    } else {
      return UserModel.empty();
    }
  }
}
