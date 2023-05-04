import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  FirebaseAuth getFirebaseAuth() {
    return _firebaseAuth;
  }

  @override
  Future<String?> currentUserUid() async {
    User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String?> signInWithEmailAndPassword({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user?.uid;
  }

  @override
  Future<String?> createUserWithEmailAndPassword({required String email, required String password}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user?.uid;
  }

  @override
  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    user?.sendEmailVerification();
  }

  @override
  Future<bool?> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    return user?.emailVerified;
  }
}