import 'package:flutter/material.dart';

import 'package:labyrinth/data/user.dart';
import 'package:labyrinth/data/settings.dart';

class UserProvider with ChangeNotifier {
  User _currentUser = Settings.user;

  User get currentUser => _currentUser;

  Future<void> setUser(User user) async {
    _currentUser = user;
    await Settings.setUser(user);
    notifyListeners();
  }

  Future<void> clearUser() async {
    await Settings.clearUser();
    notifyListeners();
  }

  /// Sets the user as online using data from Firebase Auth.
  void setOnlineUser(String id, String username) {
    _currentUser = User.online(id: id, username: username);
    notifyListeners();
  }

  /// Updates the offline user's username.
  void updateUser({String? username, String? avatar}) {
    _currentUser = User.create(
        id: _currentUser.id,
        username: username ?? _currentUser.username,
        isOnline: false,
        avatar: avatar ?? _currentUser.avatar);
    Settings.setUser(_currentUser);
    notifyListeners();
  }

  /// Resets the user to an offline state.
  void newOfflineUser() {
    _currentUser = User.offline();
    notifyListeners();
  }
}
