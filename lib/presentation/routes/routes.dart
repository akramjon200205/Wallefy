import 'package:flutter/material.dart';
import 'package:wallefy/presentation/pages/add_data.dart';
import 'package:wallefy/presentation/pages/edit_data.dart';
import 'package:wallefy/presentation/pages/settings.dart';
import 'package:wallefy/presentation/pages/view_page.dart';

class Routes {
  static const viewPage = '/';
  static const addDataPage = '/addDataPage';
  static const editData = '/editData';
  static const settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case viewPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ViewPage(),
          );
        case addDataPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => AddData(
              isTrue: args?['isTrue'],
            ),
          );
        case editData:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => EditData(
              user: args?['user'],
            ),
          );
        case settings:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const SettingsPage(),
          );
        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ViewPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ViewPage(),
      );
    }
  }
}
