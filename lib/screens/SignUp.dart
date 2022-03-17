// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lmn_neston/screens/LoginPage .dart';

import '../database/auth_methods.dart';
import '../database/user_api.dart';
import '../models/users.dart';
import '../widgets/custom_toast.dart';
import '../widgets/show_loading.dart';
import 'delayed-annimation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = '/SignupScreen';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final int delayedAmount = 500;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  /////////
  void _submitForm() async {
    if (_key.currentState!.validate()) {
      if (_password.text.trim() == _confirmPassword.text.trim()) {
        showLoadingDislog(context);
        FocusScope.of(context).unfocus();
        final User? _user = await AuthMethod().signupWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );
        if (_user == null) {
          Navigator.of(context).pop();
          return;
        }
        // String date = DateTime.now().toString();
        // DateTime dateparse = DateTime.parse(date);
        // String formattedDate =
        //     '${dateparse.day}-${dateparse.month}-${dateparse.year}';
        // String _imageURL = '';
        // if (_pickedImage != null) {
        //   _imageURL =
        //       await UserAPI().uploadImage(File(_pickedImage!.path), _user.uid);
        // }
        AppUserModel _appUser = AppUserModel(
          id: _user.uid,
          // name: _name.text.trim(),
          email: _email.text.trim(),
          // imageUrl: _imageURL,
          // createdAt: Timestamp.now(),
          // joinedAt: formattedDate,
          password: _password.text.trim(),
        );
        final bool _save = await UserAPI().addUser(_appUser);
        if (_save) {
          CustomToast.successToast(message: 'Signup successfully');
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoginPage.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pop();
        }
      } else {
        CustomToast.errorToast(
          message: 'Password and confirm password should be same',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: DelayedAnimation(
          delay: delayedAmount + 1000,
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              // scrollDirection: ,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AvatarGlow(
                    endRadius: 90,
                    duration: const Duration(seconds: 2),
                    glowColor: Colors.black,
                    repeat: true,
                    repeatPauseDuration: const Duration(seconds: 1),
                    startDelay: const Duration(seconds: 1),
                    child: Material(
                        elevation: 8.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.teal[100],
                          child: const Icon(
                            Icons.audiotrack,
                            color: Colors.teal,
                            size: 50.0,
                          ),
                          radius: 50.0,
                        )),
                  ),
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Create an Account,Its free",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        makeInput(label: "Email", all_controller: _email),
                        makeInput(
                            label: "Password",
                            obsureText: true,
                            all_controller: _password),
                        makeInput(
                            label: "Confirm Pasword",
                            obsureText: true,
                            all_controller: _confirmPassword)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 1, left: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black))),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () => _submitForm(),
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(LoginPage.routeName
                              //arguments: (Route<dynamic> route) => false,
                              );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

Widget makeInput({label, obsureText = false, required all_controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        controller: all_controller,
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
