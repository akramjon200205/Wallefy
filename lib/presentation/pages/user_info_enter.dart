import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';

class UserInfoEnter extends StatefulWidget {
  const UserInfoEnter({super.key});

  @override
  State<UserInfoEnter> createState() => _UserInfoEnterState();
}

class _UserInfoEnterState extends State<UserInfoEnter> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Info",
          style: AppTextStyles.body20w5.copyWith(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            TextField(
              controller: userNameController,
              style: AppTextStyles.body15w4.copyWith(
                color: AppColors.black,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.yellow,
                    width: 1,
                  ),
                ),
                hintText: "Foydalanuvchi nomini kiriting",
                hintStyle: AppTextStyles.body15w4.copyWith(
                  color: AppColors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.yellow,
                ),
                child: Text(
                  "Tasdiqlash",
                  style: AppTextStyles.body15w4.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
