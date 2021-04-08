import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceUtils {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserAnouncementKey = "ANNOUNCEMENTKEY";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";
  static String sharedPreferenceUserMatricKey = "USERMATRICKEY";
  static String sharedPreferenceUserVerifiedKey = "USERVERIFIEDKEY";
  static String sharedPreferenceCreatedAccountKey = "CREATEDACCOUNTKEY";
  static String sharedPreferenceSetupKey = "SETUPKEY";
  static String sharedPreferenceUploadedIdKey = "UPLOADEDIDKEY";

  //saving data to shared Preference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveCreatedAccountSharedPreference(
      bool isCreatedAccount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceSetupKey, isCreatedAccount);
  }

  static Future<bool> saveSetupSharedPreference(bool isSetup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceSetupKey, isSetup);
  }

  static Future<bool> saveUploadedIdSharedPreference(bool isUploadedId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUploadedIdKey, isUploadedId);
  }

  static Future<bool> saveUserAnouncementSharedPreference(
      bool isAnouncement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        sharedPreferenceUserAnouncementKey, isAnouncement);
  }

  static Future saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future saveUserMatricSharedPreference(String userMatric) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserMatricKey, userMatric);
  }

  static Future saveUserVerifiedSharedPreference(
      String userVerification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        sharedPreferenceUserVerifiedKey, userVerification);
  }

  //get data from  sharedPreference

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<bool> getCreatedAccountSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceCreatedAccountKey);
  }

  static Future<bool> getSetupSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceSetupKey);
  }

  static Future<bool> getUploadedIdSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUploadedIdKey);
  }

  static Future<bool> getUserAnouncementSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserAnouncementKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getUserMatricSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserMatricKey);
  }

  static Future<String> getUserVerifiedSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserVerifiedKey);
  }
}
