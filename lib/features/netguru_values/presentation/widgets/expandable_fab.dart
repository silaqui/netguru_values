import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final List<Widget> children;

  const ExpandableFab({Key key, this.children}) : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<Color> _buttonIcon;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  final double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: Curves.easeOut),
    ));
    super.initState();
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _buttonColor = ColorTween(
      begin: Theme.of(context).primaryColor,
      end: Theme.of(context).secondaryHeaderColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.00, 1.00),
    ));
    _buttonIcon = ColorTween(
      begin: Theme.of(context).secondaryHeaderColor,
      end: Theme.of(context).primaryColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.00, 1.00),
    ));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ...extraButtons(widget.children),
        toggleButton(),
      ],
    );
  }

  List<Widget> extraButtons(List<Widget> widget) {
    final List<Widget> list = <Widget>[];
    for (var i = widget.length; i > 0; i--) {
      list.add(
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * i, 0.0),
          child: widget[i - 1],
        ),
      );
    }
    return list;
  }

  Widget toggleButton() {
    return FloatingActionButton(
      backgroundColor: _buttonColor.value,
      onPressed: () => animate(),
      tooltip: 'Expand actions',
      heroTag: 'Toggle',
      child: AnimatedIcon(
        color: _buttonIcon.value,
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  void animate() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }
}
