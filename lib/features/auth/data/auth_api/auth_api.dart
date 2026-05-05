import 'dart:convert';
import 'package:ecommerce_app_api_26/features/auth/data/models/error_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/request/login_request_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/request/signup_request_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/response/login_error_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/response/login_response_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/response/signup_error_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/response/signup_response_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/token_model.dart';
import 'package:ecommerce_app_api_26/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app_api_26/core/api/end_points.dart';

class AuthApi {
  // Future<LoginResponseModel> login({
  //   required String email,
  //   required String password,}) async {
  //   Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.login);

  //   LoginRequestModel loginRequest = LoginRequestModel(
  //     email: email,
  //     password: password,
  //   );

  //   var response = await http.post(
  //     url,
  //     body: jsonEncode(loginRequest.toJson()),
  //     headers: {"Content-Type": "application/json"},
  //   );

  //   var json = jsonDecode(response.body);

  //   if (response.statusCode == 201 || response.statusCode == 200) {
  //     LoginResponseModel tokenModel = LoginResponseModel.fromJson(json);
  //     return tokenModel;
  //   } else {
  //     LoginErrorModel errorModel = LoginErrorModel.fromJson(json);
  //     throw Exception(errorModel.message);
  //   }
  // }

  // Future<SignupResponseModel> signup(
  //     String name,
  //     String email,
  //     String password) async {
  //   Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.signUp);

  //   SignupRequestModel signupRequest = SignupRequestModel(
  //     name: name,
  //     email: email,
  //     password: password,
  //   );

  //   var response = await http.post(
  //     url,
  //     body: jsonEncode(signupRequest.toJson()),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //   String responseBody = response.body;
  //   var json = jsonDecode(responseBody);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return SignupResponseModel.fromJson(json);
  //   } else {
  //     SignupErrorModel error = SignupErrorModel.fromJson(json);
  //     throw Exception(error.message);
  //   }
  // }

  Future<TokenModel> login(String email, String password) async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.login);
    Map<String, dynamic> requestedBody = {
      ApiKeys.email: email,
      ApiKeys.password: password,
    };
    var response = await http.post(
      url,
      body: jsonEncode(requestedBody),
      headers: {"Content-Type": "application/json"},
    );

    var json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      TokenModel token = TokenModel.fromJson(json);
      return token;
    } else {
      ErroeModel error = ErroeModel.fromJson(json);
      throw Exception(error.message);
    }
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.signUp);
    Map<String, dynamic> requestedBody = {
      ApiKeys.name: name,
      ApiKeys.email: email,
      ApiKeys.password: password,
      ApiKeys.avatar: "https://i.imgur.com/DTfowdu.jpg",
    };
    var response = await http.post(
      url,
      body: jsonEncode(requestedBody),
      headers: {"Content-Type": "application/json"},
    );

    var json = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel user = UserModel.fromJson(json);
      return user;
    } else {
      ErroeModel error = ErroeModel.fromJson(json);
      throw Exception(
        "   ${error.message} and statuscode is ${error.statusCode}",
      );
    }
  }
}
