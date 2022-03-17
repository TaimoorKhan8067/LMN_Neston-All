import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Name Here";
  String email = "Email Here at mail com";
  String phone = "Phone Here";
  String branch = "Branch Here";
  String position = "Position Here";
  String address = "Address Here";
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height / 12,
                  ),
                  CircleAvatar(
                    radius: _width < _height ? _width / 4 : _height / 4,
                    backgroundImage: const AssetImage('assets/girl.jpg'),
                  ),
                  SizedBox(
                    height: _height / 25.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _width / 15,
                    ),
                  ),
                  const Divider(color: Colors.black, indent: 20, endIndent: 20),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 30, left: _width / 8, right: _width / 8),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    phone,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    position,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    branch,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Text(
                    address,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: _width / 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ))
      ],
    );
  }
}
