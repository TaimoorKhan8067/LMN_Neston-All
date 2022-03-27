// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:lmn_neston/database/user_local_data.dart';
import 'package:lmn_neston/screens/Drawer.dart';
import 'package:lmn_neston/screens/Posts.dart';

import '../configs/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body:
            // Column(
            // children: [
            // const Text(
            //   "Create a Post",
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const Padding(
            //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            //   child: TextField(
            //     keyboardType: TextInputType.multiline,
            //     maxLines: 10,
            //     decoration: InputDecoration(
            //       contentPadding:
            //           EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Colors.grey,
            //         ),
            //       ),
            //       border: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey)),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 30.0,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 60),
            //   child: Container(
            //     padding: const EdgeInsets.only(top: 1, left: 1),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(40),
            //         border: const Border(
            //             bottom: BorderSide(color: Colors.black),
            //             top: BorderSide(color: Colors.black),
            //             right: BorderSide(color: Colors.black),
            //             left: BorderSide(color: Colors.black))),
            //     child: MaterialButton(
            //       minWidth: double.infinity,
            //       height: 50,
            //       onPressed: () {},
            //       color: appPrimaryColor,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(60)),
            //       child: const Text(
            //         "Submit",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontSize: 16,
            //             color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            // const Text(
            //   "Home",
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Container(
            // height: height ,
            // child:
            Posts()
        //),
        // ],
        // ),
        );
  }
}

class CardforHomePage extends StatelessWidget {
  const CardforHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Guide to Points & Referrals",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/dummy.jpg'),
                ),
              ),
              Row(
                children: [
                  const Text("Learn more about rewards"),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(appPrimaryColor),
                    ),
                    onPressed: null,
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
