import 'package:flutter/material.dart';
import 'package:wallefy/presentation/pages/add_category.dart';
import 'package:wallefy/presentation/pages/add_data.dart';
import 'package:wallefy/presentation/pages/category.dart';
import 'package:wallefy/presentation/pages/edit_data.dart';
import 'package:wallefy/presentation/pages/login.dart';
import 'package:wallefy/presentation/pages/mobile_scanner_widget.dart';
import 'package:wallefy/presentation/pages/settings.dart';
import 'package:wallefy/presentation/pages/user_info_enter.dart';
import 'package:wallefy/presentation/pages/valute.dart';
import 'package:wallefy/presentation/pages/view_page.dart';
import 'package:wallefy/presentation/widgets/add_edit_category_page.dart';

class Routes {
  static const viewPage = '/';
  static const userInfoEnter = '/userInfoEnter';
  static const login = '/login';
  static const valute = '/valute';
  static const scannerWidget = '/scannerWidget';
  static const addDataPage = '/addDataPage';
  static const editData = '/editData';
  static const settings = '/settings';
  static const category = '/category';
  static const addEditCategoryPage = "/addEditCategoryPage";
  static const addCategoryPage = "/addCategoryPage";

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case login:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const Login(),
          );
        case userInfoEnter:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const UserInfoEnter(),
          );
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
        case valute:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ValutePage(),
          );
        case scannerWidget:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ScanerWidget(),
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
        case category:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const CategoryPage(),
          );
        case addEditCategoryPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => AddEditCategoryPage(
              categoryModel: args?['categoryModel'],
            ),
          );
        case addCategoryPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const AddCategoryPage(),
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
