import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddnangcao_project/models/user.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_services.dart';
import '../../../providers/user_provider.dart';
import 'i_auth.dart';

class AuthController implements IAuth {
  static String resetUrl = "";
  ApiServiceImpl apiServiceImpl = ApiServiceImpl();

  @override
  Future<String> loginUser(String email, String password,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String resMessage;
    final response = await apiServiceImpl.post(
        url: 'login',
        params: {'email': email, 'password': password},
        needTokenAndUserId: false);
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200 &&
        data['metadata']['user']['role'] == "vendor" && data['metadata']['user']['status'] == "active") {
      resMessage = data["message"];
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
      data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      List<dynamic> stores = data['metadata']['user']['stores'];

      List<String> storeIds = stores.map<String>((store) =>
          store['_id'].toString()).toList();

      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);
      await prefs.setStringList("storeId", storeIds);
      Provider.of<UserProvider>(context, listen: false)
          .setUser(data['metadata']['user']);
    } else if(data['metadata']['user']['status'] == "pending"){
      resMessage = GlobalVariable.waitingAdminApprove;
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
      data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      List<dynamic> stores = data['metadata']['user']['stores'];

      List<String> storeIds = stores.map<String>((store) =>
          store['_id'].toString()).toList();

      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);
      await prefs.setStringList("storeId", storeIds);
    }
    else {
      return "Incorrect Email or Password!";
    }
    return resMessage;
  }

  @override
  Future<String> registerUser(String name, String email, String password,
      String passwordConfirm) async {
    late String message;

    final response = await apiServiceImpl.post(
        url: "signup",
        params: {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": passwordConfirm,
          "role": "vendor"
        },
        needTokenAndUserId: false);

    final Map<String, dynamic> data = jsonDecode(response.body);
    message = data["message"];
    return message;
  }

  @override
  Future<int> forgotPass(String email) async {
    late int statusCode;

    final response = await apiServiceImpl.post(
        url: "forgotPassword",
        params: {"email": email},
        needTokenAndUserId: false);
    final Map<String, dynamic> data = jsonDecode(response.body);
    statusCode = data["status"];
    return statusCode;
  }

  @override
  Future<List<String>> verifyForgotPass(String email, String otp) async {
    List<String> responseString = [];
    late String resMessage;

    final response = await apiServiceImpl.post(
        url: "verify?type=forgotPwd",
        params: {"email": email, "OTP": otp},
        needTokenAndUserId: false);
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    resetUrl = data['metadata']['resetURL'];
    if (resetUrl.contains("localhost")) {
      resetUrl = resetUrl.replaceFirst("localhost", "10.0.2.2");
    }
    responseString.add(resMessage);
    responseString.add(resetUrl);
    return responseString;
  }

  @override
  Future<String> verifySignUp(String email, String otp,
      BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    late String resMessage;

    final response = await apiServiceImpl.post(
        url: "verify?type=signUp",
        params: {"email": email, "OTP": otp},
        needTokenAndUserId: false);

    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    if (response.statusCode == 201) {
      String accessToken = data['metadata']['tokens']['accessToken'].toString();
      String refreshToken =
      data['metadata']['tokens']['refreshToken'].toString();
      String userId = data['metadata']['user']['_id'].toString();
      String name = data['metadata']['user']['name'].toString();
      String email = data['metadata']['user']['email'].toString();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString("refreshToken", refreshToken);
      await prefs.setString("userId", userId);
      await prefs.setString("name", name);
      await prefs.setString("email", email);

    } else {
      return resMessage;
    }
    return resMessage;
  }

  @override
  Future<String> resetPass(String password, String passwordConfirm,
      String token) async {
    late String resMessage;
    final response = await apiServiceImpl.post(
        url: token,
        params: {"password": password, "passwordConfirm": password},
        changeUrl: true,
        needTokenAndUserId: false);
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    return resMessage;
  }

  //chat
  //create new user
  // @override
  // Future<UserCredential> signUpWithEmailAndPass(String email, String password,
  //     String userId) async {
  //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //   try {
  //     UserCredential userCredential = await _firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //
  //     _fireStore.collection('users').doc(userCredential.user!.uid).set({
  //       //'uid' : userCredential.user!.uid,
  //       'uid': userId,
  //       'email': email
  //     });
  //     return userCredential;
  //   } on FirebaseException catch (e) {
  //     throw Exception(e.code);
  //   }
  // }

  @override
  Future<UserCredential> signInWithEmailAndPass(String email,
      String password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email},
          SetOptions(merge: true));
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> registerStore(String storeName,
      String address,
      File? image,
      String timeOpen,
      String timeClose,
      String latitude,
      String longtitude,) async {
    final response = await apiServiceImpl.postFormData(url: "store",
        params: {"name": storeName,
          "address": address,
          "image": image,
          "time_open": timeOpen,
          "time_close": timeClose,
          "longtitude": longtitude,
          "latitude": latitude
        },
        nameFieldImage: "image");
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
  }
}
