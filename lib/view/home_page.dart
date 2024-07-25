import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleauth/view/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar(
        "Success",
        "Logout completed!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => const Loginpage());
      });
    } catch (e) {
      print("Sign out error: $e");
      Get.snackbar(
        "Error",
        "Failed to sign out. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(
          "Logged in as: ${user.email!}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
