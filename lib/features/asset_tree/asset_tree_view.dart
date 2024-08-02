import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/features/asset_tree/components/expandable_tile.dart';
import 'package:tractian/support/components/default_app_bar.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';

class AssetTreeView extends StatefulWidget {
  final UnitEnum unit;

  const AssetTreeView({super.key, required this.unit});

  @override
  State<AssetTreeView> createState() => _AssetTreeViewState();
}

class _AssetTreeViewState extends State<AssetTreeView> {
  late final AssetTreeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ServiceLocator.get<AssetTreeBloc>(param1: widget.unit);
    bloc.add(AssetTreeLoadAssetsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssetTreeBloc, AssetTreeState>(
      listener: _viewEventsListener,
      bloc: bloc,
      builder: (_, state) {
        return Scaffold(
          appBar: DefaultAppBar(title: state.unit.title),
          body: CustomScrollView(
            slivers: [
              SliverList.list(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const Divider(height: 12),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.separated(
                  itemCount: state.locations.length,
                  itemBuilder: (_, index) {
                    return ExpandableTile(component: state.locations[index]);
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 20);
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.separated(
                  itemCount: state.assets.length,
                  itemBuilder: (_, index) {
                    return ExpandableTile(component: state.assets[index]);
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 20);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _viewEventsListener(BuildContext context, AssetTreeState state) {}
}
