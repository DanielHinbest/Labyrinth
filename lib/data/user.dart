import 'dart:math';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String username;
  final bool isOnline;
  final String? avatar;

  User.create(
      {required this.id,
      required this.username,
      required this.isOnline,
      required this.avatar});

  /// Creates an offline user with a random username.
  factory User.offline() {
    return User.create(
      id: Uuid().v4(),
      username: _generateRandomName(),
      isOnline: false,
      avatar: null,
    );
  }

  /// Creates an online user.
  factory User.online({required String id, required String username}) {
    return User.create(
      id: id,
      username: username,
      isOnline: true,
      avatar: null,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User.create(
      id: json['id'],
      username: json['username'],
      isOnline: json['isOnline'],
      avatar: null, // TODO: disabled for now
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'isOnline': isOnline,
      'avatar': avatar,
    };
  }

  /// Generate a random username.
  static String _generateRandomName() {
    final adjectives = [
      "Swift",
      "Brave",
      "Bold",
      "Clever",
      "Bright",
      "Wise",
      "Happy",
      "Jolly"
    ];
    final nouns = [
      "Fox",
      "Eagle",
      "Tiger",
      "Lion",
      "Panda",
      "Bear",
      "Wolf",
      "Hawk"
    ];
    final random = Random();
    return '${adjectives[random.nextInt(adjectives.length)]} ${nouns[random.nextInt(nouns.length)]}';
  }

  static String _generateRandomAvatar() {
    final avatars = [
      'assets/images/1.png',
    ];
    final random = Random();
    return avatars[random.nextInt(avatars.length)];
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, isOnline: $isOnline, avatar: $avatar)';
  }
}
