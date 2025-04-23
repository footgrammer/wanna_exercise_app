import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/UI/pages/home/home_page.dart';
import 'package:wanna_exercise_app/UI/pages/login/login_view_model.dart';
import 'package:wanna_exercise_app/UI/pages/login/widgets/id_text_form_field.dart';
import 'package:wanna_exercise_app/UI/pages/login/widgets/pw_text_form_field.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final pwFocusNode = FocusNode(); // id onFieldSubmit 시 pw로 포커스 옮겨줄 때 사용
  final validatorLogin = ValidatorLogin();

  @override
  void dispose() {
    pwFocusNode.dispose();
    idController.dispose();
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
        backgroundColor: Colors.blue,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 80),
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
                            'Login',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(children: [Text('ID'), Spacer()]),
                          SizedBox(height: 4),
                          IdTextFormField(
                            idController: idController,
                            nextFocus: pwFocusNode,
                            validator: validatorLogin,
                          ),
                          SizedBox(height: 16),
                          Row(children: [Text('Password'), Spacer()]),
                          SizedBox(height: 4),
                          PwTextFormField(
                            pwController: pwController,
                            focus: pwFocusNode,
                            validator: validatorLogin,
                          ),
                          SizedBox(height: 32),
                          Consumer(
                            builder: (
                              BuildContext context,
                              WidgetRef ref,
                              Widget? child,
                            ) {
                              return ElevatedButton(
                                onPressed: () async {
                                  final viewModel = ref.read(loginViewModel);
                                  final loginResult = await viewModel.login(
                                    id: idController.text,
                                    password: pwController.text,
                                    formKey: formKey,
                                  );
                                  if (loginResult) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomePage();
                                        },
                                      ),
                                      (route) {
                                        return false;
                                      },
                                    );
                                  }
                                },
                                child: Text('Log in'),
                              );
                            },
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
}
