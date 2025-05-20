
import 'package:leo_rigging_dashboard/model/auth_model.dart';

class GlobalUser {
  static final GlobalUser _instance = GlobalUser._internal();
  factory GlobalUser() => _instance;

  GlobalUser._internal();

  // User data storage
  LoginResponse? _currentUser;

  // Set the current user
  void setUser(LoginResponse user) {
    _currentUser = user;
  }

  // Get the current user
  LoginResponse? get currentUser => _currentUser;

  // Check if a user is logged in
  bool get isLoggedIn => _currentUser != null;

  // Clear the user data (Logout)
  void clearUser() {
    _currentUser = null;
  }
}
