import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sign-In',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

/// AuthService: handles Firebase + Google sign-in
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Email/password sign up
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Sign Up Error: $e');
      return null;
    }
  }

  /// Email/password sign in
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Sign In Error: $e');
      return null;
    }
  }

  /// Google sign in (cross-platform)
  Future<User?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        // Web: use Firebase popup
        final googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile (Android/iOS) using google_sign_in 7.x
        final googleSignIn = GoogleSignIn.instance;

        await googleSignIn.initialize();
        await googleSignIn.attemptLightweightAuthentication();

        if (!googleSignIn.supportsAuthenticate()) {
          throw Exception('Platform does not support authenticate()');
        }

        final googleUser = await googleSignIn.authenticate(
          scopeHint: ['email'],
        ); // user canceled

        final googleAuth = googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          // accessToken may be unavailable in this google_sign_in version; omit it
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      return userCredential.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    if (!kIsWeb) {
      await GoogleSignIn.instance.signOut();
    }
  }

  /// Current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

/// Login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  User? _user;
  bool _loading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _loading = true);
    final user = await _authService.signInWithGoogle();
    setState(() {
      _user = user;
      _loading = false;
    });
  }

  Future<void> _handleSignOut() async {
    await _authService.signOut();
    setState(() => _user = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _user != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Signed in as: ${_user!.displayName ?? _user!.email}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handleSignOut,
                    child: const Text('Sign out'),
                  ),
                ],
              )
            : ElevatedButton.icon(
                icon: Image.asset(
                  'assets/google_logo.png', // optional Google logo
                  height: 24,
                ),
                label: const Text('Continue with Google'),
                onPressed: _handleGoogleSignIn,
              ),
      ),
    );
  }
}
