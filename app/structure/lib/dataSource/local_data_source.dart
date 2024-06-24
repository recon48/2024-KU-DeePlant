//
//
// local_data_source.
//
//

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  // 임시저장 데이터 POST
  static Future<dynamic> saveDataToLocal(String jsonData, String dest) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$dest.json');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      dynamic response = await file.writeAsString(jsonData);
      print('임시저장 성공');
      return response;
    } catch (e) {
      print('임시저장 실패: $e');
      return;
    }
  }

  // 임시저장 데이터 GET
  static Future<dynamic> getLocalData(String dest) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$dest.json');
      if (await file.exists()) {
        final response = await file.readAsString();
        print('임시저장 데이터 fetch 성공');
        return jsonDecode(response);
      } else {
        print('임시저장 데이터 없음');
        return;
      }
    } catch (e) {
      print('데이터 읽기 실패: $e');
      return;
    }
  }

  // 임시저장 데이터 삭제
  static Future<void> deleteLocalData(String dest) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$dest.json');

      if (await file.exists()) {
        await file.delete();
        print('임시저장 데이터 삭제 성공');
      } else {
        print('삭제할 데이터가 없음');
      }
    } catch (e) {
      print('데이터 삭제 실패: $e');
    }
  }
}
