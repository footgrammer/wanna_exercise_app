import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/core/on_submitted_func.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';
import 'package:wanna_exercise_app/data/view_models/auth_view_model.dart';
import 'package:wanna_exercise_app/pages/widgets/phone_text_form_field.dart';
import 'package:wanna_exercise_app/pages/widgets/pw_check_text_form_field.dart';
import 'package:wanna_exercise_app/pages/widgets/pw_text_form_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final phoneController = TextEditingController();
  final pwController = TextEditingController();
  final pwCkController = TextEditingController();
  final nicknameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final pwFocusNode = FocusNode(); // pw로 포커스 옮겨줄 때
  final pwCkFocusNode = FocusNode(); // pw check로 포커스 옮겨줄 때
  final nicknameFocusNode = FocusNode(); // nickname으로 포커스 옮겨줄 때

  @override
  void dispose() {
    pwFocusNode.dispose();
    pwCkFocusNode.dispose();
    nicknameFocusNode.dispose();

    phoneController.dispose();
    pwController.dispose();
    pwCkController.dispose();
    nicknameController.dispose();
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
                          PhoneTextFormField(
                            // TODO: 회원가입용 validator 생성 및 적용
                            phoneController: phoneController,
                            nextFocus: pwFocusNode,
                            validator: ValidatorLogin(),
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
                            nextFocus: pwCkFocusNode,
                            validator: ValidatorLogin(),
                            onSubmittedFunction:
                                () => OnSubmittedFunc.moveFocusToNext(
                                  context,
                                  pwCkFocusNode,
                                ),
                          ),
                          SizedBox(height: 16),
                          Row(children: [Text('비밀번호 확인'), Spacer()]),
                          SizedBox(height: 4),
                          PwCheckTextFormField(
                            pwCkController: pwCkController,
                            focus: pwCkFocusNode,
                            nextFocus: null,
                            validator: ValidatorLogin(),
                            onSubmittedFunction: handleRegister,
                            // TODO: register 연결
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: handleRegister,
                            // TODO: register 연결
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
    final credential = await ref
        .read(authViewModelProvider)
        .register(phone: phoneController.text, password: pwController.text);

    if (credential != null && credential.user != null) {
      // TODO: 페이지 이동
      print("회원가입 성공. 유저 UID: ${credential.user!.uid}");
    } else {
      // TODO: 스낵바 출력
      print("회원가입 실패");
    }
  }
}
