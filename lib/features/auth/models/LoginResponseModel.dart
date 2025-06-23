/*
{
    "message": "Log In Successful",
    "access_Message": "you are not a verified user. You wont be able to use some services. Please verify",
    "approvalToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NDZhNzNiNTQyYjY4MTQ1Yzk0NjkzNiIsInJvbGUiOiJ1c2VyIiwidXNlcm5hbWUiOiJNdWthcnJvbSBTb2Z0VmVuY2UiLCJPVFB2ZXJpZmllZCI6ZmFsc2UsImlhdCI6MTc0OTQ2MTc1NywiZXhwIjoxNzQ5ODA3MzU3fQ.VdQAwx5IYlpQ9t3YwKsWfSdVifsTPkHxcGEeNCvpmW8",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NDZhNzNiNTQyYjY4MTQ1Yzk0NjkzNiIsInJvbGUiOiJ1c2VyIiwidXNlcm5hbWUiOiJNdWthcnJvbSBTb2Z0VmVuY2UiLCJPVFB2ZXJpZmllZCI6ZmFsc2UsImlhdCI6MTc0OTQ2MTc1NywiZXhwIjoxNzgwOTk3NzU3fQ.BDlqFUftYj1bJlGq0zHPeFTcKYSnzpevCliqF5i26Ro",
    "user": {
        "_id": "6846a73b542b68145c946936",
        "name": "Mukarrom SoftVence",
        "phone": "01",
        "email": "mukarrom.softvence@gmail.com",
        "password": "$2b$10$Xb26bXHly6SUZK4i5S15BuW8vLkJxetJCCQ2/bqrunogOUBLB7WXK",
        "aggriedToTerms": true,
        "role": "user",
        "allowPasswordChange": false,
        "OTPverified": false,
        "isDeleted": false,
        "isBlocked": false,
        "isLoggedIn": true,
        "createdAt": "2025-06-09T09:19:55.274Z",
        "updatedAt": "2025-06-09T09:35:57.375Z",
        "__v": 0,
        "sentOTP": "865659"
    }
}
*/

import 'package:luna_3/core/models/UserModel.dart';

class LoginResponseModel {
  String? message;
  String? accessMessage;
  String? approvalToken;
  String? refreshToken;
  UserModel? user;

  LoginResponseModel({
    this.message,
    this.accessMessage,
    this.approvalToken,
    this.refreshToken,
    this.user,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessMessage = json['access_Message'];
    approvalToken = json['approvalToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}
