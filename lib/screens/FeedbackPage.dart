import 'package:flutter/material.dart';
import 'package:lmn_neston/configs/constant.dart';
import 'package:lmn_neston/database/feedback_api.dart';
import 'package:lmn_neston/database/user_local_data.dart';
import 'package:lmn_neston/models/FeedBackModel.dart';
import 'package:lmn_neston/widgets/custom_toast.dart';
import 'package:lmn_neston/widgets/show_loading.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedback = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

////
  void _submitForm() async {
    if (_key.currentState!.validate()) {
      if (_feedback.text.isNotEmpty) {
        showLoadingDislog(context);
        FocusScope.of(context).unfocus();

        // String date = DateTime.now().toString();
        // DateTime dateparse = DateTime.parse(date);
        // String formattedDate =
        //     '${dateparse.day}-${dateparse.month}-${dateparse.year}';
        // String _imageURL = '';
        // if (_pickedImage != null) {
        //   _imageURL =
        //       await FeedBackAPI().uploadImage(File(_pickedImage!.path), _user.uid);
        // }
        FeedBackModel _appUser = FeedBackModel(
          id: UserLocalData.getUserUID,
          // name: _name.text.trim(),
          feedback: _feedback.text.trim(),
          // imageUrl: _imageURL,
          // createdAt: Timestamp.now(),
          // joinedAt: formattedDate,
        );
        final bool _save = await FeedBackAPI().addFeedback(_appUser);
        if (_save) {
          CustomToast.successToast(message: 'Feedback Submited successfully');
          _feedback.text = '';
        } else {
          CustomToast.errorToast(message: 'Feedback Not Submited');
        }
      } else {
        CustomToast.errorToast(message: 'Feedback is empty');
      }
    }
  }

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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Feedback",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 50,
                    ),
                  ),
                  const Text(
                    "Leave your comments below and remember all comments left are anonymous",
                    style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  makeInput(label: "", all_controller: _feedback),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        _submitForm();
                      },
                      color: appPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ]),
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
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
        maxLines: 10,
        maxLength: 100,
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
