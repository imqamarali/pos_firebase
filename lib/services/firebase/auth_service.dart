import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      throw Exception("An error occurred while fetching current user");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred during sign in");
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred during sign up");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("An error occurred during sign out");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred while sending password reset email");
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.updateDisplayName(newEmail);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred while updating email");
    }
  }

  Future<void> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred while updating password");
    }
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.delete();
      await signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("An error occurred while deleting account");
    }
  }
}
