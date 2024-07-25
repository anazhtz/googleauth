import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference userDataRef =
      FirebaseFirestore.instance.collection('user');

  // Getter for the current user
  User? get user => auth.currentUser;

  // Sign up method with email and password
  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create user with email and password
      UserCredential response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store name and email in Firestore
      final data = {
        'Email': email,
        'Name': name,
      };

      await userDataRef.doc(response.user?.uid).set(data);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "An unexpected error occurred: ${e.toString()}";
    }
  }

  // Sign in method with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException {
      // Handle sign-in errors
      return false;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await auth.signOut();
  }
}
