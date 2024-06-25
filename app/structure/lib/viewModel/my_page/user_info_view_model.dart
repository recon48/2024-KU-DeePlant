import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/dataSource/local_data_source.dart';
import 'package:structure/model/user_model.dart';
import 'package:intl/intl.dart';

class UserInfoViewModel with ChangeNotifier {
  String userName = '';
  String userId = '';
  String userType = '';
  String createdAt = '';
  String homeAdress = '-';
  String company = '-';
  String department = '-';
  String jobTitle = '-';
  UserModel userModel;
  UserInfoViewModel(this.userModel) {
    _initialize();
  }

  void _initialize() {
    userName = userModel.name ?? 'None';
    if (userModel.type != null) {
      if (userModel.type == 'Normal') {
        userType = '일반데이터 수집자';
      } else if (userModel.type == 'Researcher') {
        userType = '연구데이터 수집자';
      } else if (userModel.type == 'Manager') {
        userType = '관리자';
      } else {
        userType = 'None';
      }
    } else {
      userName = 'None';
    }
    userId = userModel.userId ?? 'None';
    createdAt = _formatDate(userModel.createdAt) ?? 'None';
    if (userModel.homeAdress != null && userModel.homeAdress!.isNotEmpty) {
      int index = userModel.homeAdress!.indexOf('/');
      if (index != -1 && userModel.homeAdress!.substring(0, index).isNotEmpty) {
        homeAdress = userModel.homeAdress!.substring(0, index);
      }
      if (index != -1 &&
          userModel.homeAdress!.substring(index + 1).isNotEmpty) {
        homeAdress += ' ${userModel.homeAdress!.substring(index + 1)}';
      }
    }
    if (userModel.company != null && userModel.company!.isNotEmpty) {
      company = userModel.company!;
    }
    if (userModel.jobTitle != null && userModel.jobTitle!.isNotEmpty) {
      int index = userModel.jobTitle!.indexOf('/');
      if (index != -1 && userModel.jobTitle!.substring(0, index).isNotEmpty) {
        department = userModel.jobTitle!.substring(0, index);
      }
      if (index != -1 && userModel.jobTitle!.substring(index + 1).isNotEmpty) {
        jobTitle = userModel.jobTitle!.substring(index + 1);
      }
    }
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    DateFormat format = DateFormat("E, dd MMM yyyy HH:mm:ss 'GMT'");
    DateTime dateTime = format.parse(dateString);

    String formattedDate = DateFormat("yyyy/MM/dd").format(dateTime);
    return formattedDate;
  }

  BuildContext? _context;

  Future<void> clickedSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await LocalDataSource.saveDataToLocal(
        jsonEncode({'auto': null}), 'auto.json');
    userModel.reset();
    _context = context;
    movePage();
  }

  void clickedEdit(BuildContext context) {
    context.go('/home/my-page/user-detail');
  }

  void clickedChangePW(BuildContext context) {
    context.go('/home/my-page/change-pw');
  }

  void movePage() {
    _context!.go('/sign-in');
  }
}
