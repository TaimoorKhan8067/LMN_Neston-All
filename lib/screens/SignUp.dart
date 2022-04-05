// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmn_neston/screens/LoginPage .dart';

import '../configs/constant.dart';
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
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneno = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _position = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File? _pickedImage;
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
        String _imageURL = '';
        if (_pickedImage != null) {
          _imageURL =
              await UserAPI().uploadImage(File(_pickedImage!.path), _user.uid);
        }
        AppUserModel _appUser = AppUserModel(
          id: _user.uid,
          name: _name.text.trim(),
          phoneNo: _phoneno.text.trim(),
          email: _email.text.trim(),
          imageUrl: _imageURL,
          // position: _position.text.trim(),
          branch: _branch.text.trim(),
          // address: _address.text.trim(),
          password: _password.text.trim(),
          points: "0".trim(),
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
    void _pickImageGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery);
      final File pickedImageFile = File(pickedImage!.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }

    Widget _imageWidget() {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 44,
            backgroundColor: Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: _pickedImage != null
                    ? FileImage(_pickedImage!)
                    : const AssetImage('assets/dummy.jpg') as ImageProvider,
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              tooltip: 'Edit Image',
              onPressed: () {
                _pickImageGallery();
              },
              icon: Icon(
                Icons.edit,
                // size: 40,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                    const Material(
                      // elevation: 8.0,
                      // shape: CircleBorder(),
                      child: Image(image: AssetImage('assets/logo.png')),
                      //  CircleAvatar(
                      //   backgroundColor: appPrimaryColor,
                      //   child: Image(image: AssetImage('assets/logo.png')),
                      //   radius: 50.0,
                      // ),
                    ),
                    AvatarGlow(
                      endRadius: 90,
                      duration: const Duration(seconds: 2),
                      glowColor: Colors.black,
                      repeat: true,
                      repeatPauseDuration: const Duration(seconds: 1),
                      startDelay: const Duration(seconds: 1),
                      child: _imageWidget(),
                    ),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   "Create an Account,Its free",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.grey[700],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(label: "Name", all_controller: _name),
                          makeInput(label: "Email", all_controller: _email),
                          makeInput(label: "Phone", all_controller: _phoneno),
                          // makeInput(
                          //     label: "Position", all_controller: _position),
                          makeInput(label: "Branch", all_controller: _branch),
                          // makeInput(label: "Address", all_controller: _address),
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
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 1, left: 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          // border: const Border(
                          //     bottom: BorderSide(color: Colors.black),
                          //     top: BorderSide(color: Colors.black),
                          //     right: BorderSide(color: Colors.black),
                          //     left: BorderSide(color: Colors.black)),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () => _submitForm(),
                          color: appPrimaryColor,
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
                      height: 10.0,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                LoginPage.routeName
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
      )),
    );
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
      // const SizedBox(
      //   height: 30,
      // )
    ],
  );
}

/////////////////////////////////////////////////////


