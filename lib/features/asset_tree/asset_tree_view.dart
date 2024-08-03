import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/features/asset_tree/components/expandable_tile.dart';
import 'package:tractian/features/asset_tree/components/filter_option.dart';
import 'package:tractian/support/components/default_app_bar.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
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
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: DefaultAppBar(title: state.unit.title),
            body: CustomScrollView(
              slivers: [
                SliverList.list(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                      child: TextField(
                        onChanged: (search) => bloc.add(AssetTreeSearchRequested(search: search)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Buscar ativo ou local',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: FilterOptionEnum.values.map((filter) {
                          return GestureDetector(
                            onTap: () => bloc.add(AssetTreeFilterOptionRequested(filterOption: filter)),
                            child: FilterOption(
                              filterOption: filter,
                              isSelected: state.isFilterOptionSelected(filter),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Divider(
                      height: 12,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList.separated(
                    itemCount: state.components.length,
                    itemBuilder: (_, index) {
                      return ExpandableTile(
                        component: state.components[index],
                        filterOption: state.currentFilterOption,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(height: 20);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _viewEventsListener(BuildContext context, AssetTreeState state) {}
}
