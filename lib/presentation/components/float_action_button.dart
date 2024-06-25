import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/config/constants/app_text_styles.dart';
import 'package:wallefy/config/constants/constants.dart';
import 'package:wallefy/data/models/income_expenses_model.dart';
import 'package:wallefy/data/services/incomeService.dart';

class FloatActionButton extends StatefulWidget {
  const FloatActionButton({
    super.key,
    required AnimationController? animationController,
    required Animation<double>? animation,
    required this.functions,
  })  : _animationController = animationController,
        _animation = animation;
  final AnimationController? _animationController;
  final Animation<double>? _animation;

  final List<Function> functions;

  @override
  State<FloatActionButton> createState() => _FloatActionButtonState();
}

class _FloatActionButtonState extends State<FloatActionButton> {
  late List<IncomeExpensesModel> _userList = <IncomeExpensesModel>[];
  final _userService = IncomeService();

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      items: List.generate(
        3,
        (index) => Bubble(
          title: floatListNames[index],
          iconColor: Colors.white,
          bubbleColor: Colors.teal,
          icon: floatListIcons[index],
          titleStyle: AppTextStyles.body16w5.copyWith(color: AppColors.white),
          onPress: () {
            widget.functions[index]();
            widget._animationController!.reverse();
          },
        ),
      ),
      animation: widget._animation!,
      onPress: () => widget._animationController!.isCompleted
          ? widget._animationController!.reverse()
          : widget._animationController!.forward(),
      iconColor: Colors.white,
      iconData: Icons.add,
      backGroundColor: Colors.teal,
    );
  }
}
