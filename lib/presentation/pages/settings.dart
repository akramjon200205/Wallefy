import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/presentation/widgets/custom_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selLanguage = 0;
  int selCurrency = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
        title: const Text('Sozlamalar'),
      ),
      body: ListView(
        children: [
          CustomCard(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/defAvatar.jpg'),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Akramjon', style: AppTextStyles.body20w5),
                      const SizedBox(height: 20),
                      Text('Usmonov', style: AppTextStyles.body20w5),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          const CustomCard(child: Text('Premium - versiya')),
          const CustomCard(child: Text('Qarzlar')),
          const CustomCard(child: Text('Kategoriya')),
          const CustomCard(child: Text('Eksport')),
          const CustomCard(child: Text('Asosiy valyuta')),
        ],
      ),
    );
  }
}
