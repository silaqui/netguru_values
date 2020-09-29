import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/dependency_injection.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/value_display.dart';

class ValuesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NetguruValuesBloc>(),
      child: BlocBuilder<NetguruValuesBloc, NetguruValuesState>(
        builder: (BuildContext context, NetguruValuesState state) {
          if (state is Initial) {
            BlocProvider.of<NetguruValuesBloc>(context)
                .add(GetRandomNetguruValueEvent());
            return Container();
          } else if (state is Loaded) {
            return ValueDisplay(netguruValue: state.value);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
