import 'package:flutter/material.dart';
import 'package:lmn_neston/screens/SignUp.dart';

import '../configs/constant.dart';
import '../database/auth_methods.dart';
import '../database/user_local_data.dart';

class CustomDrawer extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CustomDrawer() : super();

  @override
  _LeadsDrawerState createState() => _LeadsDrawerState();
}

class _LeadsDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appPrimaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Center(
            child: DrawerHeader(
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: appBackGroundColor,
                    child: Image(image: AssetImage('assets/logo.png')),
                    radius: 50.0,
                  )),
            ),
          ),
          ListTile(
            title: const Text(' 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(' Log Out'),
            onTap: () async {
              //showLicensePage(context: context);
              await AuthMethod().signOut();
              UserLocalData.setUserUID('');

              Navigator.of(context).pushNamedAndRemoveUntil(
                SignUpPage.routeName,
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
