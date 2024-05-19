import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/config/constants/local_data.dart';
import 'package:wallefy/presentation/components/drawer.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final PageController controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 24,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      menuBackgroundColor: Colors.teal,
      mainScreen: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (number) {
            setState(() {
              selectedIndex = number;
            });
          },
          controller: controller,
          children: pages),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: CustomDrawer(
          controller: controller,
        ),
      ),
    );
  }
}
