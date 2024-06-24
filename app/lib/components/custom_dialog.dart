import 'package:deepplant/config/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDeletePhotoDialog(BuildContext context, VoidCallback? rightFunc) {
  showCustomDialog(
    context,
    'assets/images/trash_image.png',
    '사진을 삭제할까요?',
    '삭제된 사진은 복구할 수 없습니다.',
    '취소',
    '삭제',
    null,
    rightFunc,
  );
}

void showExitDialog(BuildContext context, VoidCallback? rightFunc) {
  showCustomDialog(context, 'assets/images/exit.png', '데이터가 저장되지 않았습니다',
      '창을 닫으면 모든 정보가 삭제됩니다.', '취소', '나가기', null, () {
    rightFunc;
    Navigator.pop(context);
    Navigator.pop(context);
  });
}

void showDataRegisterDialog(
    BuildContext context, VoidCallback? leftFunc, VoidCallback? rightFunc) {
  showCustomDialog(
    context,
    'assets/images/meat_eval.png',
    '임시저장 중인 데이터가 있습니다.',
    '이어서 등록하시겠습니까?',
    '처음부터 등록하기',
    '이어서 등록하기',
    leftFunc,
    rightFunc,
  );
}

void showTemporarySaveDialog(BuildContext context, VoidCallback? rightFunc) {
  showCustomDialog(
    context,
    'assets/images/exit.png',
    '임시저장 하시겠습니까?',
    '',
    '아니요',
    '네',
    null,
    rightFunc,
  );
}

// 다이얼로그 형식입니다.
void showCustomDialog(
  BuildContext context,
  String iconPath,
  String titleText,
  String contentText,
  String leftButtonText,
  String rightButtonText,
  VoidCallback? leftButtonFunc,
  VoidCallback? rightButtonFunc,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 431.h,
          width: 676.w,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 96.h,
                  width: 96.w,
                  child: Image.asset(
                    iconPath,
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  titleText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Text(contentText),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DialogButton(
                      buttonFunc: leftButtonFunc ??
                          () {
                            Navigator.pop(context);
                          },
                      buttonText: leftButtonText,
                      isLeft: true,
                    ),
                    SizedBox(
                      width: 41.w,
                    ),
                    DialogButton(
                      buttonFunc: rightButtonFunc,
                      buttonText: rightButtonText,
                      isLeft: false,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.buttonFunc,
    required this.buttonText,
    required this.isLeft,
  });

  final VoidCallback? buttonFunc;
  final String buttonText;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 255.w,
      height: 96.h,
      child: TextButton(
        onPressed: buttonFunc,
        style: ButtonStyle(
          backgroundColor: isLeft
              ? MaterialStateProperty.all<Color>(Palette.popupLeftBtnBg)
              : MaterialStateProperty.all<Color>(
                  Palette.popupRightBtnBg,
                ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
              side: BorderSide(color: const Color(0xFFD9D9D9), width: 2.w),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(230.w, 104.h)),
        ),
        child: Text(
          buttonText,
          style: isLeft
              ? Palette.dialogLeftBtnTitle
              : TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
