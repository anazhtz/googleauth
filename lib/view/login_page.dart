import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleauth/firebase_auth/firebase_helper.dart';
import 'package:googleauth/view/home_page.dart';
import 'package:googleauth/view/register_page.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var formkey = GlobalKey<FormState>();
  String? email;
  String? passs;
  bool showpass = true;

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 150,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Welcome back you!",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: emailcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal.shade400),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Mobile Number or Email Address',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      validator: (uname) {
                        if (uname!.isEmpty ||
                            !uname.contains("@") ||
                            !uname.contains(".")) {
                          return "Please enter valid Username";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (ename) {
                        email = ename;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: passwordcontroller,
                      obscureText: showpass,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (showpass) {
                                showpass = false;
                              } else {
                                showpass = true;
                              }
                            });
                          },
                          icon: Icon(showpass == true
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (upassword) {
                        if (upassword!.isEmpty || upassword.length < 6) {
                          return "please enter valid Password";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pwd) {
                        passs = pwd;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(360, 70),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final valid = formkey.currentState?.validate() ?? false;
                      if (valid) {
                        formkey.currentState?.save();
                        bool isSuccess = await FireHelper().signIn(
                          email: email!,
                          password: passs!,
                        );
                        if (isSuccess) {
                          Get.to(HomePage());
                        } else {
                          Get.snackbar("Error", "Invalid email or password");
                        }
                      }
                    },
                    child: const Text("LOGIN"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(color: Colors.grey[700]),
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
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'images/google-icon.png'),
                      SizedBox(
                        width: 25,
                      ),
                      SquareTile(imagePath: 'images/applelogo.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Registraionpage()));
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  //final String pageRout;
  const SquareTile({
    super.key,
    required this.imagePath,
    //required this.pageRout
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: IconButton(
            onPressed: () {
              //pageRout;
            },
            icon: Image.asset(
              imagePath,
              height: 40,
            )));
  }
}
