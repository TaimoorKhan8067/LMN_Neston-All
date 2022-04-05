// ignore_for_file: file_names, unnecessary_const

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmn_neston/database/posts_api.dart';
import 'package:lmn_neston/database/user_local_data.dart';
import 'package:lmn_neston/models/CreatePost.dart';
import 'package:lmn_neston/screens/MainScreen.dart';
import 'package:lmn_neston/screens/Posts.dart';

import '../configs/constant.dart';
import '../widgets/custom_toast.dart';
import '../widgets/show_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _pickedImage;

  final TextEditingController _text = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _submitForm() async {
    if (_key.currentState!.validate()) {
      if (_pickedImage?.exists() != null || _text.text.trim() != "") {
        showLoadingDislog(context);
        FocusScope.of(context).unfocus();
        String _imageURL = '';
        if (_pickedImage != null) {
          _imageURL = await PostApi()
              .uploadImage(File(_pickedImage!.path), UserLocalData.getUserUID);
        }

        CreatePost userPosts = CreatePost(
          id: UserLocalData.getUserUID,
          text: _text.text.trim(),
          imageUrl: _imageURL,
        );
        final bool _save = await PostApi().addPosts(userPosts);
        if (_save) {
          CustomToast.successToast(message: 'Uploaded successfully');
          Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pop();
        }
      } else {
        CustomToast.errorToast(
          message: 'Write Something',
        );
      }
    }
  }

  void _pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    final File pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            body: Column(
                mainAxisSize: MainAxisSize.max, //Add this line onyour column
                children: [
              makeInput(all_controller: _text),
              Expanded(child: Posts())
            ])));
  }

  // ignore: non_constant_identifier_names
  Widget makeInput({label, obsureText = false, required all_controller}) {
    return Form(
      key: _key,
      child: Column(
        children: [
          const Text(
            "Create a Post",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(children: [
              TextField(
                controller: all_controller,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                  label: const Text("Write Here ...."),
                  // helperText:  Text("Write Here ....",
                  suffixIcon: IconButton(
                    tooltip: 'Edit Image',
                    onPressed: () {
                      _pickImageGallery();
                    },
                    icon: const Icon(
                      Icons.attach_file_rounded,
                      // size: 40,
                      // color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                padding: const EdgeInsets.fromLTRB(10, 100, 0, 0),
                height: MediaQuery.of(context).size.height * 0.16,
                child: _pickedImage != null
                    ? Image(image: FileImage(_pickedImage!)
                        // : const AssetImage('assets/dummy.jpg') as ImageProvider,
                        )
                    : const Text('Image Here'),
              ),
            ]),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
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
                height: 50,
                onPressed: () => _submitForm(),
                color: appPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const Text(
            "Home",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
