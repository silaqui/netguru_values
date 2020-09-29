import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netguru_values/dependency_injection.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/netguru_values_list/netguru_values_list_bloc.dart';

class ValuesListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NetguruValuesListBloc>()..add(GetAllNetguruValuesEvent()),
      child: BlocBuilder<NetguruValuesListBloc, NetguruValuesListState>(
        builder: (BuildContext context, NetguruValuesListState state) {
          if (state is Empty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedList) {
            return ListView.builder(
              itemCount: state.value.length,
              itemBuilder: (context, index) {
                final item = state.value[index];
                return Card(
                  child: ListTile(
                    leading: item.isDefault
                        ? const Image(image: AssetImage('assets/icon/icon.png'))
                        : null,
                    title: Text(item.text),
                    trailing: IconButton(
                      icon: Icon(item.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        context
                            .bloc<NetguruValuesListBloc>()
                            .add(ToggleFavoriteNetguruValuesEvent(item));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
