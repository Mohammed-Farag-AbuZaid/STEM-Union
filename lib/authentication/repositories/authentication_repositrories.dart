import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stem_union/authentication/screens/change_academic_ifo.dart';
import 'package:stem_union/authentication/screens/email_verification.dart';
import 'package:stem_union/authentication/screens/loging/login.dart';
import 'package:stem_union/screens/home_page/home.dart';
import 'package:stem_union/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:stem_union/utils/exceptions/firebase_exceptions.dart';
import 'package:stem_union/utils/exceptions/formate_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  static const String _tfApiBaseUrl = 'https://n8n.tfunions.com/tf-api';

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    screenRedirect();
    _auth.authStateChanges().listen((user) {
      screenRedirect();
    });
  }

  bool _isRedirecting = false;

  void screenRedirect() async {
    if (_isRedirecting) return;
    _isRedirecting = true;
    try {
      final vpsUser = deviceStorage.read('tf_vps_user');
      if (vpsUser != null) {
        Get.offAll(() => const HomePage());
        return;
      }

      final user = _auth.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          final hasProfile = await _hasCompletedProfile(user.uid);
          if (!hasProfile) {
            Get.offAll(
              () => const ChangeAcademicInfo(
                showBackArrow: false,
                fullMessage: false,
                title: 'Complete Your Profile',
                description:
                    'We couldn\'t find your account details. Please visit the TF Passport portal to complete your profile.',
              ),
            );
          } else {
            Get.offAll(() => const HomePage());
          }
        } else {
          Get.offAll(() => const EmailVerification());
        }
      } else {
        deviceStorage.writeIfNull('IsFirstTime', true);
        Get.offAll(() => const LoginScreen());
      }
    } finally {
      _isRedirecting = false;
    }
  }

  Future<bool> _hasCompletedProfile(String uid) async {
    try {
      final res = await http
          .get(Uri.parse('$_tfApiBaseUrl/api/collections/users/$uid'))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) return true;
    } catch (_) {}

    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      if (kDebugMode) print('Firestore check failed: ${e.code}');
      return false;
    }
  }

  Future<UserCredential?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse('$_tfApiBaseUrl/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 8));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        await deviceStorage.write('tf_vps_token', body['access_token']);
        await deviceStorage.write('tf_vps_user', body['user']);
        return null;
      }
    } catch (_) {}

    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> logout() async {
    try {
      await deviceStorage.remove('tf_vps_token');
      await deviceStorage.remove('tf_vps_user');
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      return await _auth.signInWithPopup(googleProvider);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }
}
