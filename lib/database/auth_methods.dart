import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users.dart';
import '../widgets/custom_toast.dart';
import 'user_api.dart';
import 'user_local_data.dart';

class AuthMethod {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<bool> loginAnonymosly() async {
    try {
      await _auth.signInAnonymously();
      // String date = DateTime.now().toString();
      // DateTime dateparse = DateTime.parse(date);
      // String formattedDate =
      //     '${dateparse.day}-${dateparse.month}-${dateparse.year}';
      final AppUserModel appUser = AppUserModel(
        id: DateTime.now().microsecond.toString(),
        // name: 'Guest User',
        email: 'guest@guest.com',
        // imageUrl: '',
        NotificationToken: '',
        // createdAt: Timestamp.now(),
        // joinedAt: formattedDate,
        password: '',
        // isAdmin: false,
      );
      UserLocalData().storeAppUserData(appUser: appUser);
      return true;
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  // Future<bool> signinWithGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         // String date = DateTime.now().toString();
  //         // DateTime dateparse = DateTime.parse(date);
  //         // String formattedDate =
  //         //     '${dateparse.day}-${dateparse.month}-${dateparse.year}';
  //         final UserCredential authResult = await _auth.signInWithCredential(
  //             GoogleAuthProvider.credential(
  //                 idToken: googleAuth.idToken,
  //                 accessToken: googleAuth.accessToken));
  //         final AppUserModel _appUser = AppUserModel(
  //           id: authResult.user!.uid,
  //           // name: authResult.user!.displayName,
  //           email: authResult.user!.email,
  //           // imageUrl: authResult.user!.photoURL,
  //           // joinedAt: formattedDate,
  //           // createdAt: Timestamp.now(),
  //         );
  //         final bool _isOkay = await UserAPI().addUser(_appUser);
  //         if (_isOkay) {
  //           UserLocalData().storeAppUserData(appUser: _appUser);
  //         } else {
  //           return false;
  //         }
  //         return true;
  //       } catch (error) {
  //         CustomToast.errorToast(message: error.toString());
  //       }
  //     }
  //   }
  //   return false;
  // }

  Future<User?> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth
          .createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      assert(user != null);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final User? user = result.user;
      final DocumentSnapshot<Map<String, dynamic>> docs =
          await UserAPI().getInfo(uid: user!.uid);
      final AppUserModel appUser = AppUserModel.fromDocument(docs);
      UserLocalData().storeAppUserData(appUser: appUser);
      return user;
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    UserLocalData.signout();
    await _auth.signOut();
  }
}
