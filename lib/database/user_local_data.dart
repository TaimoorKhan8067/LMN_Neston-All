import 'package:shared_preferences/shared_preferences.dart';

import '../models/users.dart';

class UserLocalData {
  static SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void signout() => _preferences!.clear();

  static const String _uidKey = 'UIDKEY';
  static const String _emailKey = 'EMAILKEY';
  static const String _displayNameKey = 'DISPLAYNAMEKEY';
  static const String _phoneNumber = 'PHONENUMBER';
  static const String _imageUrlKey = 'IMAGEURLKEY';
  static const String _position = 'POSITION';
  static const String _branch = 'BRANCH';
  static const String _address = 'ADDRESS';
  static const String _androidNotificationToken = 'androidNotificationToken';
  static const String _points = 'points';

  //s
  // Setters
  //
  static Future<void> setUserUID(String uid) async =>
      _preferences!.setString(_uidKey, uid);

  static Future<void> setBranch(String branch) async =>
      _preferences!.setString(_branch, branch);

  static Future<void> setUserEmail(String email) async =>
      _preferences!.setString(_emailKey, email);

  static Future<void> setUserDisplayName(String name) async =>
      _preferences!.setString(_displayNameKey, name);

  static Future<void> setUserPhoneNumber(String phoneNo) async =>
      _preferences!.setString(_phoneNumber, phoneNo);

  static Future<void> setUserImageUrl(String url) async =>
      _preferences!.setString(_imageUrlKey, url);

  static Future<void> setUserPosition(String position) async =>
      _preferences!.setString(_position, position);

  static Future<void> setUserAdress(String address) async =>
      _preferences!.setString(_address, address);

  static Future<void> setAndroidNotificationToken(String token) async =>
      _preferences!.setString(_androidNotificationToken, token);

  static Future<void> setpoints(String points) async =>
      _preferences!.setString(_points, points);

  //
  // Getters
  //
  static String get getUserUID => _preferences?.getString(_uidKey) ?? '';
  static String get getBranch => _preferences!.getString(_branch) ?? '';
  static String get getUserEmail => _preferences!.getString(_emailKey) ?? '';
  static String get getUserDisplayName =>
      _preferences!.getString(_displayNameKey) ?? '';
  static String get getPhoneNumber =>
      _preferences!.getString(_phoneNumber) ?? '';
  static String get getUserImageUrl =>
      _preferences!.getString(_imageUrlKey) ?? '';
  static String get getUUserPosition =>
      _preferences!.getString(_position) ?? '';
  static String get getUUserAddress => _preferences!.getString(_address) ?? '';
  static String get getAndroidNotificationToken =>
      _preferences!.getString(_androidNotificationToken) ?? '';
  static String get getpoints => _preferences!.getString(_points) ?? '';

  void storeAppUserData({required AppUserModel appUser, String token = ''}) {
    setUserUID(appUser.id!);
    setUserEmail(appUser.email!);
    setUserDisplayName(appUser.name!);
    setUserPhoneNumber(appUser.phoneNo!);
    setUserImageUrl(appUser.imageUrl!);
    setUserPosition(appUser.position!);
    setUserAdress(appUser.address!);
    setBranch(appUser.branch!);
    setAndroidNotificationToken(token);
    setpoints(appUser.points!);
  }
}
