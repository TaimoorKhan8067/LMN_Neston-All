import 'package:flutter/material.dart';

import '../configs/constant.dart';

class Posts extends StatefulWidget {
  // final int indexRequired;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  // Posts(this.indexRequired);
  @override
  // ignore: no_logic_in_create_state
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // final int indexRequired;
  // _PostsState(this.indexRequired);
  String dropdownValue = "New Posts";

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // final items = 1000;
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: 100, // items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        // final item = items[index];
        return Card(
          elevation: 2,
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
        );
      },
    );
  }
}
