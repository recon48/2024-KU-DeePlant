//
//
// 이력 번호 페이지(수정 불가!) : Normal
//
//
import 'package:provider/provider.dart';
import 'package:deepplant/components/inner_box.dart';
import 'package:deepplant/components/custom_app_bar.dart';
import 'package:deepplant/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deepplant/config/pallete.dart';
import 'package:deepplant/viewModel/data_management/normal/not_editable/insertion_trace_num_not_editable_view_model.dart';

class InsertionTraceNumNotEditableScreen extends StatefulWidget {
  const InsertionTraceNumNotEditableScreen({super.key});

  @override
  State<InsertionTraceNumNotEditableScreen> createState() =>
      _InsertionTraceNumNotEditableScreenState();
}

class _InsertionTraceNumNotEditableScreenState
    extends State<InsertionTraceNumNotEditableScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: '육류 기본정보',
          backButton: true,
          closeButton: false,
        ),
        body: Column(
          children: [
            SizedBox(height: 49.h),
            if (context
                    .watch<InsertionTraceNumNotEditableViewModel>()
                    .isAllInserted ==
                1)
              Expanded(
                  child: ListTable(
                      tableData: context
                          .read<InsertionTraceNumNotEditableViewModel>()
                          .tableData))
            else if (context
                    .read<InsertionTraceNumNotEditableViewModel>()
                    .isAllInserted ==
                2)
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 45.0,
                    ),
                    child: Text(
                      '검색결과가 없습니다',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              )
            else if (context
                    .read<InsertionTraceNumNotEditableViewModel>()
                    .isAllInserted ==
                0)
              const Spacer(
                flex: 2,
              ),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: MainButton(
                mode: 1,
                text: '다음',
                width: 658.w,
                height: 104.h,
                onPressed: () => context
                    .read<InsertionTraceNumNotEditableViewModel>()
                    .clickedNextButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTable extends StatelessWidget {
  ListTable({super.key, required this.tableData});

  final List<String?> tableData;
  final List<String> baseData = [
    '이력번호',
    '출생년월일',
    '육종/축종',
    '성별',
    '경영자',
    '사육지',
    '도축일자',
    '등급',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: baseData.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: InnerBox(
                  text: baseData[index],
                  style: Palette.h5Grey,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: (baseData[index] == '사육지' && (tableData[2] != '돼지'))
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InnerBox(
                          text: tableData[index],
                          style: Palette.h4Grey,
                        ),
                      )
                    : InnerBox(
                        text:
                            (tableData[index] != null) ? tableData[index] : "",
                        style: Palette.h4Grey,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
