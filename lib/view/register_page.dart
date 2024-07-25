import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleauth/firebase_auth/firebase_helper.dart';
import 'package:googleauth/view/login_page.dart';

class Registraionpage extends StatefulWidget {
  const Registraionpage({super.key});

  @override
  State<Registraionpage> createState() => _RegistraionpageState();
}

class _RegistraionpageState extends State<Registraionpage> {
  String? email;
  String? passs;
  String? name;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false; // Loading state variable

  Future<void> _handleRegistration() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      formKey.currentState!.save();
      String? errorMessage = await FireHelper().signUp(
        email: email!,
        password: passs!,
        name: name!,
      );

      setState(() {
        isLoading = false;
      });

      if (errorMessage == null) {
        Get.snackbar(
          "Success",
          "Registration successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Get.to(() => const Loginpage());
        });
      } else {
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Create New Account ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        prefixIcon: const Icon(Icons.text_fields),
                        labelStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Enter some value";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (uname) {
                        name = uname;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email address",
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        labelStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (uemail) {
                        if (uemail!.isEmpty ||
                            !uemail.contains("@") ||
                            !uemail.contains(".")) {
                          return "Please enter a valid email address";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (ename) {
                        email = ename;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        prefixIcon: const Icon(Icons.password),
                        labelStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "Password cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pwd) {
                        passs = pwd;
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size(350, 70),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _handleRegistration,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text("SUBMIT"),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
