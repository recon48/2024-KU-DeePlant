//
//
// 가열육 관능평가(ViewModel) : Researcher
//
//

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/config/userfuls.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class HeatedMeatEvalViewModel with ChangeNotifier {
  MeatModel meatModel;
  HeatedMeatEvalViewModel(this.meatModel) {
    _initialize();
  }
  bool isLoading = false;
  bool completed = false;

  // 임시 변수
  double flavor = 0;
  double juiciness = 0;
  double tenderness = 0;
  double umami = 0;
  double palatability = 0;

  // 초기 할당 (객체에 값이 존재시 할당)
  void _initialize() {
    flavor = meatModel.heatedmeat?["flavor"] ?? 0;
    juiciness = meatModel.heatedmeat?["juiciness"] ?? 0;
    tenderness = meatModel.heatedmeat?["tenderness"] ?? 0;
    umami = meatModel.heatedmeat?["umami"] ?? 0;
    palatability = meatModel.heatedmeat?["palability"] ?? 0;
    _checkAllInserted();
    notifyListeners();
  }

  // 관능평가 값 할당.
  void onChangedFlavor(dynamic value) {
    flavor = double.parse(value.toStringAsFixed(1));
    _checkAllInserted();
    notifyListeners();
  }

  void onChangedJuiciness(dynamic value) {
    juiciness = double.parse(value.toStringAsFixed(1));
    _checkAllInserted();
    notifyListeners();
  }

  void onChangedTenderness(dynamic value) {
    tenderness = double.parse(value.toStringAsFixed(1));
    _checkAllInserted();
    notifyListeners();
  }

  void onChangedUmami(dynamic value) {
    umami = double.parse(value.toStringAsFixed(1));
    _checkAllInserted();
    notifyListeners();
  }

  void onChangedPalatability(dynamic value) {
    palatability = double.parse(value.toStringAsFixed(1));
    _checkAllInserted();
    notifyListeners();
  }

  // 모든 값 입력 확인.
  void _checkAllInserted() {
    if (flavor != 0 &&
        juiciness != 0 &&
        tenderness != 0 &&
        umami != 0 &&
        palatability != 0) {
      completed = true;
    } else {
      completed = false;
    }
  }

  late BuildContext _context;

  // 데이터를 객체에 할당 (이후 POST)
  Future<void> saveData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    meatModel.heatedmeat ??= {};
    meatModel.heatedmeat!['createdAt'] = Usefuls.getCurrentDate();
    print(meatModel.butcheryYmd);
    meatModel.heatedmeat!['period'] = Usefuls.getMeatPeriod(meatModel);
    meatModel.heatedmeat!['flavor'] = flavor;
    meatModel.heatedmeat!['juiciness'] = juiciness;
    meatModel.heatedmeat!['tenderness'] = tenderness;
    meatModel.heatedmeat!['umami'] = umami;
    meatModel.heatedmeat!['palability'] = palatability;
    meatModel.checkCompleted();

    try {
      dynamic response = await RemoteDataSource.sendMeatData(
          'heatedmeat_eval', meatModel.toJsonHeated());
      if (response == null) {
        throw Error();
      } else {
        _context = context;
        _movePage();
      }
    } catch (e) {
      print("에러발생: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void _movePage() {
    if (meatModel.seqno == 0) {
      // 원육
      _context.go('/home/data-manage-researcher/add/raw-meat');
    } else {
      // 처리육
      _context.go('/home/data-manage-researcher/add/processed-meat');
    }
  }
}
