import 'package:flutter/material.dart';

class ExpandableFabRadial extends StatefulWidget {
  final List<Widget> children;

  const ExpandableFabRadial({Key key, this.children}) : super(key: key);

  @override
  _ExpandableFabRadialState createState() => _ExpandableFabRadialState();
}

class _ExpandableFabRadialState extends State<ExpandableFabRadial>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<Color> _buttonIcon;
  Animation _degOneTranslationAnimation;
  Animation _degTwoTranslationAnimation;
  Animation _degThreeTranslationAnimation;
  List<Animation> _degAnimationList;
  Animation _rotationAnimation;
  Animation<double> _animateIcon;

  double getRadiansFromDegree(double degree) {
    const double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(_animationController);
    _degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(_animationController);
    _degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(_animationController);
    _rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _degAnimationList = [
      _degOneTranslationAnimation,
      _degTwoTranslationAnimation,
      _degThreeTranslationAnimation
    ];
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
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        IgnorePointer(
          child: Container(
            height: 150.0,
            width: 150.0,
          ),
        ),
        ...extraButtons(widget.children),
        toggleButton(),
      ],
    );
  }

  List<Widget> extraButtons(List<Widget> widget) {
    final List<Widget> list = <Widget>[];
    final changeAngel = 90 / (widget.length - 1);
    for (var i = 0; i < widget.length; i++) {
      list.add(buttonsArrangement(
          270.0 - changeAngel * i, _degAnimationList[i % 3], widget[i]));
    }
    return list;
  }

  Widget buttonsArrangement(
      double radialPosition, Animation animation, Widget child) {
    return Transform.translate(
      offset: Offset.fromDirection(
          getRadiansFromDegree(radialPosition), animation.value * 100),
      child: Transform(
        transform:
            Matrix4.rotationZ(getRadiansFromDegree(_rotationAnimation.value))
              ..scale(animation.value),
        alignment: Alignment.center,
        child: child,
      ),
    );
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
