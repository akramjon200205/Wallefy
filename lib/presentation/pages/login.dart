import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/presentation/components/custom_textfield.dart';
import 'package:wallefy/presentation/routes/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Login",
              style: AppTextStyles.body32w5.copyWith(
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: emailController,
              style: AppTextStyles.body20w4.copyWith(color: AppColors.black),
              hintText: "Email",
              hintStyle:
                  AppTextStyles.body20w4.copyWith(color: AppColors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: passwordController,
              style: AppTextStyles.body20w4.copyWith(
                color: AppColors.black,
              ),
              radius: 10,
              isPassword: true,
              hintText: 'Parol kiriting',
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.userInfoEnter);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.yellow,
                ),
                child: Text(
                  "Ro'yhatdan o'tish",
                  style: AppTextStyles.body20w4.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "Kirish",
                style: AppTextStyles.body16w4
                    .copyWith(color: AppColors.actionsClmnnClr),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
