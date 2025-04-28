import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/core/on_submitted_func.dart';
import 'package:wanna_exercise_app/core/validator_util.dart';
import 'package:wanna_exercise_app/data/view_models/auth_view_model.dart';
import 'package:wanna_exercise_app/pages/home/home_page.dart';
import 'package:wanna_exercise_app/pages/widgets/phone_text_form_field.dart';
import 'package:wanna_exercise_app/pages/widgets/pw_text_form_field.dart';
import 'package:wanna_exercise_app/pages/widgets/show_custom_snack_bar.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final phoneController = TextEditingController();
  final pwController = TextEditingController();
  final pwCkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final validatorUtil = ValidatorUtil();

  final pwFocusNode = FocusNode(); // pw로 포커스 옮겨줄 때
  final pwCkFocusNode = FocusNode(); // pw check로 포커스 옮겨줄 때

  String? phoneValidationMessage;
  bool? isPhoneAvailable;

  @override
  void dispose() {
    pwFocusNode.dispose();
    pwCkFocusNode.dispose();

    phoneController.dispose();
    pwController.dispose();
    pwCkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: Image.asset('assets/images/wanna_exercise.png'),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text(
                            '회원가입',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "계정이 있으신가요?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  color: Colors.transparent,
                                  child: Text(
                                    "로그인",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [Text('전화번호'), Spacer()]),
                          SizedBox(height: 4),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: PhoneTextFormField(
                                      phoneController: phoneController,
                                      nextFocus: pwFocusNode,
                                      validator:
                                          validatorUtil.registerValidatorPhone,
                                      validateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onSubmittedFunction:
                                          () => OnSubmittedFunc.moveFocusToNext(
                                            context,
                                            pwFocusNode,
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      final available = await ref
                                          .read(authViewModelProvider)
                                          .isPhoneAvailable(
                                            phoneController.text,
                                          );
                                      setState(() {
                                        isPhoneAvailable = available;
                                        if (isPhoneAvailable == null) {
                                          phoneValidationMessage = null;
                                        } else if (!isPhoneAvailable!) {
                                          phoneValidationMessage =
                                              '이미 등록된 전화번호입니다.';
                                        } else if (isPhoneAvailable!) {
                                          phoneValidationMessage =
                                              '사용 가능한 전화번호입니다.';
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '중복 확인',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (phoneValidationMessage != null)
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    phoneValidationMessage!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          isPhoneAvailable == true
                                              ? primaryColor
                                              : negativeColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(children: [Text('비밀번호'), Spacer()]),
                          SizedBox(height: 4),
                          PwTextFormField(
                            pwController: pwController,
                            focus: pwFocusNode,
                            nextFocus: pwCkFocusNode,
                            validator: validatorUtil.registerValidatorPw,
                            validateMode: AutovalidateMode.onUserInteraction,
                            onSubmittedFunction:
                                () => OnSubmittedFunc.moveFocusToNext(
                                  context,
                                  pwCkFocusNode,
                                ),
                          ),
                          SizedBox(height: 16),
                          Row(children: [Text('비밀번호 확인'), Spacer()]),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: pwCkController,
                            decoration: InputDecoration(hintText: '비밀번호 확인'),
                            focusNode: pwCkFocusNode,
                            maxLength: 20,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '비밀번호를 한번 더 입력하세요.';
                              }
                              if (value != pwController.text) {
                                return '비밀번호가 일치하지 않습니다.';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: handleRegister,
                            child: Text('회원가입'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleRegister() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (isPhoneAvailable == null) {
      setState(() {
        phoneValidationMessage = "전화번호 중복 확인을 진행해주세요.";
      });
      return;
    }
    if (!isPhoneAvailable!) {
      return;
    }

    final credential = await ref
        .read(authViewModelProvider)
        .register(phone: phoneController.text, password: pwController.text);

    if (credential != null && credential.user != null) {
      showCustomSnackBar(
        context,
        text: '회원가입 완료! ${phoneController.text} 로그인되었습니다.',
        bottomPadding: 100,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
        (route) => false, // 모든 이전 페이지 제거
      );
    } else {
      showCustomSnackBar(
        context,
        text: '회원가입에 실패했습니다. 잠시 후 다시 시도해 주세요.',
        bottomPadding: 100,
      );
    }
  }
}
