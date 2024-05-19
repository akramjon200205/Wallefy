import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';
import 'package:wallefy/presentation/components/float_action_button.dart';
import 'package:wallefy/presentation/pages/history.dart';
import 'package:wallefy/presentation/widgets/table_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<IncomeExpensesModel> _userList = <IncomeExpensesModel>[];
  final _userService = IncomeService();
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  getAllUserDetails() async {
    var users = await _userService.readAllData();
    _userList = <IncomeExpensesModel>[];
    users.forEach((user) {
      setState(() {
        var userModel = IncomeExpensesModel();
        userModel.id = user['id'];
        userModel.desc = user['desc'];
        userModel.price = user['price'];
        _userList.add(userModel);
      });
    });
  }

  Animation<double>? _animation;
  AnimationController? _animationController;
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

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
        title: const Text("Wallefy"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const HistoryPage()));
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: ListView(
        children: const [
          TableWidget(),
        ],
      ),
      floatingActionButton: FloatActionButton(
          animationController: _animationController, animation: _animation),
    );
  }
}
