import 'package:clean_mvvm_project/presentation/forgot_password/forgot_password_viewModel.dart';
import 'package:clean_mvvm_project/presentation/resources/strings_manager.dart';
import 'package:clean_mvvm_project/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.forgotPassword),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.p12),
          child: Column(
            children: [
              const SizedBox(height: AppPaddings.p100),
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(height: AppPaddings.p20),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: _viewModel.emailChanged,
              ),
              const SizedBox(height: AppPaddings.p20),
              //reset btn
              StreamBuilder<bool>(
                  stream: _viewModel.isEmailValid,
                  builder: (context, AsyncSnapshot<bool?> snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data == true
                          ? () {
                              _viewModel.resetPassword();
                            }
                          : null,
                      child: const Text(AppStrings.resetPassword),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
