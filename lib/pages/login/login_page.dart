import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/core/on_submitted_func.dart';
import 'package:wanna_exercise_app/data/view_models/auth_view_model.dart';
import 'package:wanna_exercise_app/pages/home/home_page.dart';
import 'package:wanna_exercise_app/pages/register/register_page.dart';
import 'package:wanna_exercise_app/pages/widgets/phone_text_form_field.dart';
import 'package:wanna_exercise_app/pages/widgets/pw_text_form_field.dart';
import 'package:wanna_exercise_app/core/validator_util.dart';
import 'package:wanna_exercise_app/pages/widgets/show_confirm_pop_up.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final phoneController = TextEditingController();
  final pwController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final pwFocusNode = FocusNode(); // id onFieldSubmit 시 pw로 포커스 옮겨줄 때 사용
  final validatorUtil = ValidatorUtil();

  @override
  void dispose() {
    pwFocusNode.dispose();
    phoneController.dispose();
    pwController.dispose();
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
                            '로그인',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "아직 계정이 없으신가요?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return RegisterPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    color: Colors.transparent,
                                    child: Text(
                                      "회원가입",
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
                          ),
                          Row(children: [Text('전화번호'), Spacer()]),
                          SizedBox(height: 4),
                          PhoneTextFormField(
                            phoneController: phoneController,
                            nextFocus: pwFocusNode,
                            validator: validatorUtil.loginValidatorPhone,
                            validateMode: AutovalidateMode.disabled,
                            onSubmittedFunction:
                                () => OnSubmittedFunc.moveFocusToNext(
                                  context,
                                  pwFocusNode,
                                ),
                          ),
                          SizedBox(height: 16),
                          Row(children: [Text('비밀번호'), Spacer()]),
                          SizedBox(height: 4),
                          PwTextFormField(
                            pwController: pwController,
                            focus: pwFocusNode,
                            nextFocus: null,
                            validator: validatorUtil.loginValidatorPw,
                            validateMode: AutovalidateMode.disabled,
                            onSubmittedFunction: handleLogin,
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: handleLogin,
                            child: Text('로그인'),
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

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final credential = await ref
        .read(authViewModelProvider)
        .login(phone: phoneController.text, password: pwController.text);

    if (credential != null && credential.user != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
        (route) => false, // 모든 이전 페이지 제거
      );
      print("로그인 성공! 유저 UID: ${credential.user!.uid}");
    } else {
      print("로그인 실패");
    }
  }
}
