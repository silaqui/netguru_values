import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/expandable_fab.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/favorite_switch.dart';
import 'package:netguru_values/features/netguru_values/presentation/widgets/values_body.dart';
import 'package:netguru_values/features/routes/router.gr.dart';

import '../../../../dependency_injection.dart';

class NetguruValuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NetguruValuesBloc>(),
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
//                      bloc.add(ToggleFavoriteNetguruValuesEvent(value));
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
        floatingActionButton: ExpandableFab(
          children: <Widget>[
            add(context),
            valueList(context),
            FavoriteSwitch(),
          ],
        ),
      ),
    );
  }

  Widget add(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => ExtendedNavigator.of(context).push(Routes.addValuePage),
      tooltip: 'Add Your Value',
      heroTag: 'Add Your Value',
      child: Icon(Icons.add),
    );
  }

  Widget valueList(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          ExtendedNavigator.of(context).push(Routes.netguruValuesListPage),
      tooltip: 'All Our Values',
      heroTag: 'All Our Values',
      child: Icon(Icons.list),
    );
  }

}
