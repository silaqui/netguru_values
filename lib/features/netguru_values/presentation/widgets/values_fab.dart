import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

class ValuesFab extends StatefulWidget {
  @override
  _ValuesFabState createState() => _ValuesFabState();
}

class _ValuesFabState extends State<ValuesFab> with TickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _buttonColor = ColorTween(
      begin: Theme.of(context).primaryColor,
      end: Theme.of(context).secondaryHeaderColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00, curve: Curves.linear),
    ));
    super.didChangeDependencies();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () =>
            ExtendedNavigator.of(context).push(Routes.addValuePage),
        tooltip: 'Add Your Value',
        heroTag: 'Add Your Value',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget valueList() {
    return Container(
      child: FloatingActionButton(
        onPressed: () =>
            ExtendedNavigator.of(context).push(Routes.netguruValuesListPage),
        tooltip: 'All Our Values',
        heroTag: 'All Our Values',
        child: Icon(Icons.list),
      ),
    );
  }

  Widget toggleOnlyFavorite() {
    return Container(
      child: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Show Favorite',
        heroTag: 'Show Favorite',
        child: Icon(Icons.favorite_border),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Expand actions',
        heroTag: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 3.0, 0.0),
          child: add(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 2.0, 0.0),
          child: valueList(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value, 0.0),
          child: toggleOnlyFavorite(),
        ),
        toggle(),
      ],
    );
  }
}
