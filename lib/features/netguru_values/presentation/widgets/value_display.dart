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
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
          netguruValue.text,
          key: const Key('value text field'),
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
