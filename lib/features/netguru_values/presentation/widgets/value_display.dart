import 'package:flutter/widgets.dart';
import 'package:netguru_values/features/netguru_values/domain/entities/netguru_value.dart';

class ValueDisplay extends StatelessWidget {
  final NetguruValue netguruValue;

  const ValueDisplay({
    Key key,
    @required this.netguruValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Text(
          netguruValue.text,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
