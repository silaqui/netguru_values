import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/core/theme/theme.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/add_value/add_value_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/add_value_scaffold.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/saving_in_progress_overlay.dart';

import '../../../../dependency_injection.dart';

class AddValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddValueBloc>(),
      child: BlocConsumer<AddValueBloc, AddValueState>(
        listener: (context, state) {
          if (state is Error) {
            FlushbarHelper.createError(message: state.message).show(context);
          }
          if (state is Saved) {
            ExtendedNavigator.of(context).pop();
            Flushbar(
              message: 'Your Value is also Our Value',
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: primaryColor,
              ),
              leftBarIndicatorColor: primaryColor,
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              AddValueScaffold(),
              if (state == Saving()) SavingInProgressOverlay(),
            ],
          );
        },
      ),
    );
  }
}
