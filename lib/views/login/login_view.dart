import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:togg_app/core/constants/app_constants.dart';
import 'package:togg_app/core/managers/assets_manager.dart';
import 'login_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel;

  Widget get _buildLoginButton => SizedBox(
        width: 250.w,
        height: 50.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF18C1E8),
          ),
          onPressed: loginViewModel.loginFakeIsProcess
              ? () {}
              : () => loginViewModel.loginFake(),
          child: Text(
            loginViewModel.loginFakeIsProcess ? "LOGGING IN.." : "LOGIN",
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      );

  Widget get _buildLogo => SvgPicture.asset(
        AssetManager.instance.getSvgImage(AppConstants.toggLogoSvg),
      );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        loginViewModel = viewModel;
        return Scaffold(
          body: _buildBody,
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }

  Widget get _buildBody => Form(
        key: loginViewModel.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              _buildLogo,
              SizedBox(height: 80.h),
              _buildTf(
                "Kullanıcı Adı",
                loginViewModel.nameController,
                false,
                false,
              ),
              SizedBox(height: 10.h),
              _buildTf(
                "Şifre",
                loginViewModel.passController,
                loginViewModel.obscureText,
                true,
              ),
              SizedBox(height: 10.h),
              _buildLoginButton,
            ],
          ),
        ),
      );

  Widget _buildTf(
    String labelText,
    TextEditingController controller,
    bool obscureText,
    bool showSuffixIcon,
  ) =>
      SizedBox(
        width: 250.w,
        child: TextFormField(
          validator: (c) {
            if (c.isEmpty) {
              return "Bu alan boş bırakılamaz";
            }
            return null;
          },
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: !showSuffixIcon
                ? null
                : GestureDetector(
                    onTap: () => loginViewModel.changeObscureText(),
                    child: loginViewModel.obscureText
                        ? Icon(Icons.lock)
                        : Icon(Icons.lock_open_rounded),
                  ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 10.w,
            ),
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
        ),
      );
}
