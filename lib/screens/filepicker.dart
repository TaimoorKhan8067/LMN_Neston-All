import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmn_neston/database/doc_api.dart';
import 'package:lmn_neston/models/docUpload.dart';

import 'package:path/path.dart';

import '../configs/constant.dart';
import '../database/firebase_api.dart';
import '../database/user_local_data.dart';
import '../widgets/custom_toast.dart';
import '../widgets/show_loading.dart';
import 'MainScreen.dart';

// ignore: use_key_in_widget_constructors
class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  UploadTask? task;
  File? _pickedDoc;

  // void _pickFiles() async {
  //   try {
  //     _controller.text = "pdf";
  //     _directoryPath = null;
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: false,
  //       onFileLoading: (FilePickerStatus status) => print(status),
  //     ))
  //         ?.files;
  //     // ignore: empty_catches
  //   } on PlatformException catch (e) {
  //     // ignore: empty_catches
  //   } catch (e) {}
  //   if (!mounted) return;
  //   setState(() {
  //     _isLoading = false;
  //     _fileName =
  //         _paths != null ? _paths!.map((e) => e.name).toString() : '...';
  //     _userAborted = _paths == null;
  //     _pickedDoc = File(_fileName!);
  //     _submitForm();
  //   });
  // }

  // Future uploadFile() async {
  //       String _imageURL = '';
  //       if (_pickedImage != null) {
  //         _imageURL = await PostApi()
  //             .uploadImage(File(_pickedImage!.path), UserLocalData.getUserUID);
  //       }

  //       CreatePost userPosts = CreatePost(
  //         id: UserLocalData.getUserUID,
  //         text: _text.text.trim(),
  //         imageUrl: _imageURL,
  //       );
  //       final bool _save = await PostApi().addPosts(userPosts);
  //       if (_save) {
  //         CustomToast.successToast(message: 'Uploaded successfully');
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             MainScreen.routeName, (Route<dynamic> route) => false);
  //       }

  //   }
  // if (_fileName == null) return;

  // final fileName = basename(_fileName!);
  // final destination = 'files/$fileName';

  // task = FirebaseApi.uploadFile(destination, file!);
  // setState(() {});

  // if (task == null) return;

  // final snapshot = await task!.whenComplete(() {});
  // final urlDownload = await snapshot.ref.getDownloadURL();

  // print('Download-Link: $urlDownload');
  // }

  // void _logException(String message) {
  //   print(message);
  //   _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  //   _scaffoldMessengerKey.currentState?.showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _resetState() {
  //   if (!mounted) {
  //     return;
  //   }
  //   setState(() {
  //     _isLoading = true;
  //     _directoryPath = null;
  //     _fileName = null;
  //     _paths = null;
  //     _saveAsFileName = null;
  //     _userAborted = false;
  //   });
  // }

  void _pickDoc() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    final File pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedDoc = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _submitForm() async {
      _pickDoc();
      showLoadingDislog(context);

      String _imageURL = '';
      if (_pickedDoc != null) {
        _imageURL = await DocApi()
            .uploadImage(File(_pickedDoc!.path), UserLocalData.getUserUID);
      }
      // _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      CreateDoc userDoc = CreateDoc(
        id: UserLocalData.getUserUID,
        imageUrl: _imageURL,
      );
      final bool _save = await DocApi().addPosts(userDoc);
      if (_save) {
        CustomToast.successToast(message: 'Uploaded successfully');
        Navigator.of(context).pushNamedAndRemoveUntil(
            MainScreen.routeName, (Route<dynamic> route) => false);
      } else {}
    }

    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () => _submitForm(),
      color: appPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: const Text(
        "Upload",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
