class AuthRepository {
  Future<bool> register({required String email, required String password}) async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));
    return true; // Return true to simulate successful registration
  }
}

