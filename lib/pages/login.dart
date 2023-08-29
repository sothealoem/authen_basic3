import 'package:basic3/pages/forgetpassword.dart';
import 'package:basic3/pages/home.dart';
import 'package:basic3/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //loginValidation

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user_not_found') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No User Found for that email',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong_password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Wrong  Password Provided by User',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF283793),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/above1.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.9,
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Welcome\nBack',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(height: 30.0),

                //email text field
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFF4c59a5),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email Address';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: 'Your Email',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30.0),

                //password text field
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFF4c59a5),
                      borderRadius: BorderRadius.circular(22)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        hintText: 'Your Password',
                        hintStyle: TextStyle(color: Colors.white60)),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 24.0),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(
                        () {
                          email = emailController.text;
                          password = passwordController.text;
                        },
                      );
                    }
                    userLogin();
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFf95f3b),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New User?',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          color: Color(0xFFf95f3b),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
