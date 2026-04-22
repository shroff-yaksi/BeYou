import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:beyou/core/utils/exceptions.dart';
import 'package:beyou/core/service/user_service.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User> signUp(String email, String password, String name) async {
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User user = result.user!;
      await user.updateDisplayName(name);
      await UserService.createUserDocument(user, name: name);
      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = result.user;

      if (user == null) {
        throw Exception("User not found");
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
  }

  /// Signs in with Google. Returns null if the user cancelled.
  static Future<User?> signInWithGoogle() async {
    try {
      UserCredential result;
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('email');
        provider.addScope('profile');
        result = await auth.signInWithPopup(provider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) return null; // user cancelled
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        result = await auth.signInWithCredential(credential);
      }
      final User user = result.user!;
      await UserService.createUserDocument(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }
}

String getExceptionMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'No account found with this email.';
    case 'wrong-password':
    case 'invalid-credential':
    case 'INVALID_LOGIN_CREDENTIALS':
      return 'Incorrect email or password.';
    case 'invalid-email':
      return 'Invalid email address.';
    case 'user-disabled':
      return 'This account has been disabled.';
    case 'too-many-requests':
      return 'Too many failed attempts. Please try again later.';
    case 'email-already-in-use':
      return 'An account with this email already exists.';
    case 'weak-password':
      return 'Password must be at least 6 characters.';
    case 'requires-recent-login':
      return 'Please sign in again before retrying this request.';
    case 'network-request-failed':
      return 'Network error. Check your connection.';
    default:
      return e.message ?? 'Authentication failed. Please try again.';
  }
}
