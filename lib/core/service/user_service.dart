import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beyou/core/utils/exceptions.dart';
import 'package:beyou/core/service/auth_service.dart';

class UserService {
  static final FirebaseAuth firebase = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a Firestore document for a newly registered user.
  static Future<void> createUserDocument(User user, {String? name}) async {
    final docRef = _db.collection('users').doc(user.uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'email': user.email ?? '',
        'name': name ?? user.displayName ?? '',
        'photoUrl': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Updates editable profile fields in Firestore.
  static Future<void> updateUserDocument(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Fetches the current user's Firestore document.
  static Future<Map<String, dynamic>?> getUserDocument(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  static Future<bool> editPhoto(String photoUrl) async {
    try {
      await firebase.currentUser?.updatePhotoURL(photoUrl);
      final uid = firebase.currentUser?.uid;
      if (uid != null) {
        await _db.collection('users').doc(uid).update({
          'photoUrl': photoUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> changeUserData(
      {required String displayName, required String email}) async {
    try {
      await firebase.currentUser?.updateDisplayName(displayName);
      await firebase.currentUser?.verifyBeforeUpdateEmail(email);
      final uid = firebase.currentUser?.uid;
      if (uid != null) {
        await _db.collection('users').doc(uid).update({
          'name': displayName,
          'email': email,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Saves user goals and fitness level to Firestore after onboarding.
  static Future<void> saveGoals({
    required String uid,
    required List<String> goals,
    required String fitnessLevel,
  }) async {
    await _db.collection('users').doc(uid).update({
      'goals': goals,
      'fitnessLevel': fitnessLevel,
      'onboardingComplete': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<bool> changePassword({required String newPass}) async {
    try {
      await firebase.currentUser?.updatePassword(newPass);
      return true;
    } on FirebaseAuthException catch (e) {
      throw CustomFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await firebase.signOut();
  }
}
