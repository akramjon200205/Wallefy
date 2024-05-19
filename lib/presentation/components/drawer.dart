import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/config/constants/local_data.dart';
import 'package:wallefy/presentation/components/drawer_button.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.controller});
  final PageController controller;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/defAvatar.jpg'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Akramjon',
                  style:
                      AppTextStyles.body20w5.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 30),
              ],
            ),
            Column(
              children: List.generate(
                pages.length,
                (index) => GestureDetector(
                    onTap: () {
                      _onItemTapped(index);
                      ZoomDrawer.of(context)!.close();
                    },
                    child: DraverButton(
                        icon: pageIcons[index], text: pageNames[index])),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  callShowDialog(context);
                },
                child: const DraverButton(
                    icon: Icons.exit_to_app_outlined, text: 'Exit')),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 2) {
      showDialogInfo(context);
    } else {
      widget.controller.animateToPage(selectedIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  Future<dynamic> showDialogInfo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Dastur haqida')),
        actionsAlignment: MainAxisAlignment.spaceAround,
        content: const Text(
          'Sizning daromad va harajatlaringizni monitoring qilish',
          textAlign: TextAlign.center,
        ),
        actions: [
          Column(
            children: [
              const Text('v 1.0'),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> callShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выйти из программы'),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  textStyle: const TextStyle(fontSize: 15)),
              onPressed: () {
                exit(0);
              },
              child: const Text('Да')),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Нет')),
        ],
      ),
    );
  }
}
