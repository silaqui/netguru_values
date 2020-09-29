import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/radial_expandable_fab/extra_fab_buttons_radial.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_body.dart';

import 'file:///C:/git/netguru_values/lib/features/netguru_values/presentation/widgets/radial_expandable_fab/expandable_fab_radial.dart';
import 'file:///C:/git/netguru_values/lib/features/netguru_values/presentation/widgets/radial_expandable_fab/favorite_switch_radial.dart';

import '../../../../dependency_injection.dart';

class NetguruValuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NetguruValuesBloc>()..add(GetRandomNetguruValueEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Netguru Values'),
          actions: <Widget>[
            BlocBuilder<NetguruValuesBloc, NetguruValuesState>(
              builder: (BuildContext context, NetguruValuesState state) {
                final bloc = context.bloc<NetguruValuesBloc>();
                if (bloc.state is Loaded) {
                  final state = bloc.state as Loaded;
                  final value = state.value;
                  return IconButton(
                    icon: Icon(value.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      bloc.add(ToggleFavoriteNetguruValuesEvent(value));
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        body: ValuesBody(),
        floatingActionButton: ExpandableFabRadial(
          children: <Widget>[
            addRadial(context),
            valueListRadial(context),
            FavoriteSwitchRadial(),
          ],
        ),
      ),
    );
  }
}
