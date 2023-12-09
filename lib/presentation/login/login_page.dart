import 'package:clean_mvvm_project/data/repository/repository_impl.dart';
import 'package:clean_mvvm_project/domain/usecases/login_usecase.dart';
import 'package:clean_mvvm_project/presentation/resources/strings_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import 'login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _loginViewModel =
      LoginViewModel(LoginUseCase(_repositoryImpl));
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  _bind() {
    _loginViewModel.start();
    _userNameController.addListener(() {
      _loginViewModel.setUserName(_userNameController.text);
    });
    _passwordController.addListener(() {
      _loginViewModel.setPassword(_passwordController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(AppPaddings.p12),
              child: Column(
                children: [
                  const SizedBox(height: AppPaddings.p100),
                  Image.asset(ImageAssets.splashLogo),
                  const SizedBox(height: AppPaddings.p20),
                  //username
                  StreamBuilder<bool>(
                      stream: _loginViewModel.outPutIsUserNameValid,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return TextFormField(
                          onChanged: (value) {},
                          controller: _userNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: AppStrings.userName,
                            hintText: AppStrings.userName,
                            //at the start data is null
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.userNameError,
                          ),
                        );
                      }),
                  const SizedBox(height: AppPaddings.p20),
                  //password
                  StreamBuilder<bool>(
                      stream: _loginViewModel.outPutIsPasswordValid,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return TextFormField(
                          onChanged: (value) {},
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            hintText: AppStrings.password,
                            //at the start data is null
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError,
                          ),
                        );
                      }),
                  const SizedBox(height: AppPaddings.p20),
                  //login
                  StreamBuilder<bool>(
                      stream: _loginViewModel.outPutIsAllValid,
                      builder: (context, AsyncSnapshot<bool?> snapshot) {
                        return ElevatedButton(
                          onPressed: snapshot.data == true
                              ? () {
                                  _loginViewModel.login();
                                }
                              : null,
                          child: const Text(AppStrings.login),
                        );
                      }),
                  //forgot and register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.forgotPasswordRoute);
                        },
                        child: const Text(
                          AppStrings.forgotPassword,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.registerRoute);
                        },
                        child: const Text(AppStrings.registerNow),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
