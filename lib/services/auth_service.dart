import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, [this.code]);

  @override
  String toString() => message;
}

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    forceCodeForRefreshToken: true,
  );

  // Stream for auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Email login
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication failed';

      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      } else if (e.code == 'user-disabled') {
        message = 'This user account has been disabled';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many login attempts. Try again later';
      }

      throw AuthException(message, e.code);
    } catch (e) {
      throw AuthException('Failed to sign in: ${e.toString()}');
    }
  }

  // Google Sign-In with email account picker
  Future<User?> signInWithGoogle({bool forceAccountPicker = true}) async {
    try {
      // Force sign out to show account picker
      if (forceAccountPicker) {
        await _googleSignIn.signOut();
      }

      // Sign in to get the selected account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException('Google sign-in was cancelled');
      }

      // Get authentication from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'Google sign-in failed';

      if (e.code == 'invalid-credential') {
        message = 'Invalid Google credentials. Please try again';
      } else if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with this email';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Google sign-in is not enabled';
      }

      throw AuthException(message, e.code);
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }
      throw AuthException('Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      throw AuthException('Failed to sign out: ${e.toString()}');
    }
  }

  // Email signup
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      String message = 'Sign up failed';

      if (e.code == 'weak-password') {
        message = 'Password is too weak. Use at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email is already in use';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }

      throw AuthException(message, e.code);
    } catch (e) {
      throw AuthException('Failed to sign up: ${e.toString()}');
    }
  }

  // Check if user is admin
  bool isAdmin(String? email) {
    return email == 'mariyumarif66@gmail.com';
  }
}
