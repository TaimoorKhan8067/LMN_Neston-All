// ignore: file_names
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lmn_neston/screens/MainScreen.dart';
import 'package:lmn_neston/screens/SignUp.dart';

import '../configs/constant.dart';
import '../database/auth_methods.dart';
import '../database/user_local_data.dart';
import '../widgets/custom_toast.dart';
import '../widgets/show_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          body: Center(
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              const Spacer(),
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
              const Text(
                "Log  In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Log In with your Account",
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
                    // border: const Border(
                    //     bottom: BorderSide(color: Colors.black),
                    //     top: BorderSide(color: Colors.black),
                    //     right: BorderSide(color: Colors.black),
                    //     left: BorderSide(color: Colors.black)),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //   MainScreen.routeName,
                      //   (Route<dynamic> route) => false,
                      // );
                      if (_key.currentState!.validate()) {
                        showLoadingDislog(context);
                        final User? _user =
                            await AuthMethod().loginWithEmailAndPassword(
                          _email.text.trim(),
                          _password.text.trim(),
                        );
                        if (_user != null) {
                          UserLocalData.setUserUID(_user.uid);
                          print(_user.uid);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            MainScreen.routeName,
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          Navigator.of(context).pop();
                          CustomToast.errorToast(
                              message: 'email OR password in incorrect');
                        }
                      }
                    },
                    color: appPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: const Text(
                      "Log  In",
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
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignUpPage.routeName
                              //arguments: (Route<dynamic> route) => false,
                              );
                    },
                    child: const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
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
        obscureText: obsureText,
        controller: all_controller,
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
