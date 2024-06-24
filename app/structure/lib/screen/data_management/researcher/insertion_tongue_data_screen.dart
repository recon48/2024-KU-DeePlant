//
//
// 전자혀 데이터 페이지(View)
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:deepplant/components/custom_app_bar.dart';
import 'package:deepplant/components/main_button.dart';
import 'package:deepplant/components/tongue_field.dart';
import 'package:deepplant/viewModel/data_management/researcher/insertion_tongue_data_view_model.dart';

class InsertionTongueDataScreen extends StatefulWidget {
  const InsertionTongueDataScreen({super.key});

  @override
  State<InsertionTongueDataScreen> createState() =>
      _InsertionTongueDataScreenState();
}

class _InsertionTongueDataScreenState extends State<InsertionTongueDataScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 키보드 unfocus
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: '전자혀 데이터',
          backButton: true,
          closeButton: false,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                // 'TongueFiled' 컴포넌트를 이용하여 전자혀 데이터 측정
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  TongueFiled(
                    mainText: 'Sourness',
                    subText: '신맛',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().sourness,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Bitterness',
                    subText: '진한맛',
                    controller: context
                        .watch<InsertionTongueDataViewModel>()
                        .bitterness,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Umami',
                    subText: '감칠맛',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().umami,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Richness',
                    subText: '후미',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().richness,
                  ),
                  SizedBox(
                    height: 400.h,
                  ),
                  // 데이터 저장 버튼
                  Container(
                    margin: EdgeInsets.only(bottom: 28.h),
                    child: MainButton(
                      onPressed: () async => context
                          .read<InsertionTongueDataViewModel>()
                          .saveData(context),
                      text: '저장',
                      width: 658.w,
                      height: 104.h,
                      mode: 1,
                    ),
                  ),
                ],
              ),
              context.watch<InsertionTongueDataViewModel>().isLoading
                  ? const CircularProgressIndicator()
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
