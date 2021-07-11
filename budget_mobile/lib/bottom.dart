import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'enums.dart';
import 'expenses.dart';
import 'income.dart';
class TutorialOverlay1 extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);
  @override
  String? get barrierLabel => null;
  @override
  bool get maintainState => true;
  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           ExpensesList(),
             RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done'),)
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
class TutorialOverlay2 extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);
  @override
  String? get barrierLabel => null;
  @override
  bool get maintainState => true;
  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IncomeList(),
           RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done'),
          )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
class CustomBottom extends StatefulWidget {
  @override
  _CustomBottomState createState() => _CustomBottomState();
}

class _CustomBottomState extends State<CustomBottom> {
    void _showOverlayExpenses(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay1());
  }
  void _showOverlayIncome(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay2());
  }
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/expenses.svg",
                    color: Colors.pink,
                  ),
                  onPressed: () {
                    _showOverlayExpenses(context);

                  }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/profit.svg",
                    color: Colors.pink,
                  ),
                  onPressed: () {
                     _showOverlayIncome(context);
                  }),
            ],
          )),
    );
  }
}
