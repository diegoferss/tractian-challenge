import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/features/asset_tree/components/expandable_tile.dart';
import 'package:tractian/features/asset_tree/components/filter_option.dart';
import 'package:tractian/support/components/default_app_bar.dart';
import 'package:tractian/support/components/slivers/default_sliver_empty_message.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';
import 'package:tractian/support/styles/app_colors.dart';

import '../../support/utils/localize.dart';

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
    final l10n = Localize.instance.l10n;

    return BlocBuilder<AssetTreeBloc, AssetTreeState>(
      bloc: bloc,
      builder: (_, state) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: DefaultAppBar(title: l10n.assetTreeTitle),
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
                          fillColor: AppColors.lightGrey,
                          hintText: l10n.assetTreeInputHint,
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
                      color: AppColors.lightGrey,
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: _bodyWidget(state, context, l10n),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bodyWidget(AssetTreeState state, BuildContext context, Localization l10n) {
    if (state.viewState.isLoading) {
      return SliverList.list(
        children: [
          const SizedBox(height: 40),
          const Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            child: Text(
              l10n.assetTreeLoadingLabel,
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    if (state.viewState.hasError) {
      return SliverList.list(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            child: Text(
              l10n.assetTreeErrorLabel,
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: AppColors.highlightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => bloc.add(AssetTreeLoadAssetsRequested()),
              child: Text(
                l10n.assetTreeTryAgainButton,
                style: context.headlineSmall?.copyWith(color: AppColors.backgroundColor),
              ),
            ),
          ),
        ],
      );
    }

    if (state.baseItems.isEmpty && state.search.isEmpty) {
      return DefaultSliverEmptyMessage(
        message: l10n.assetTreeEmptyResultLabel,
      );
    }

    if (state.baseItems.isEmpty) {
      return DefaultSliverEmptyMessage(
        message: l10n.assetTreeEmptySearchLabel,
      );
    }

    return SliverList.separated(
      itemCount: state.baseItems.length,
      itemBuilder: (_, index) {
        return ExpandableTile(
          baseItem: state.baseItems[index],
          search: state.search,
          isAssetPathExpanded: state.isAssetPathExpanded,
          filterOption: state.currentFilterOption,
        );
      },
      separatorBuilder: (_, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
