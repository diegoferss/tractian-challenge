import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tractian/features/asset_tree/components/expandable_tile.dart';
import 'package:tractian/features/asset_tree/components/filter_option.dart';
import 'package:tractian/support/components/default_app_bar.dart';
import 'package:tractian/support/components/slivers/default_sliver_empty_message.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';
import 'package:tractian/support/styles/app_colors.dart';

import '../../support/utils/localize.dart';
import 'models/base_item.dart';

abstract class AssetTreeViewModelProtocol with ChangeNotifier {
  FilterOptionEnum? get filterOption;
  bool get isAssetPathExpanded;
  String get search;
  ViewStateEnum get viewState;
  List<BaseItem> get baseItems;

  void loadContent();
  void updateSearch(String search);
  void updateFiterOption(FilterOptionEnum filterOption);
  bool isFilterOptionSelected(FilterOptionEnum filterOption);
}

class AssetTreeView extends StatefulWidget {
  final UnitEnum unit;

  const AssetTreeView({super.key, required this.unit});

  @override
  State<AssetTreeView> createState() => _AssetTreeViewState();
}

class _AssetTreeViewState extends State<AssetTreeView> {
  late AssetTreeViewModelProtocol viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ServiceLocator.get<AssetTreeViewModelProtocol>(param1: widget.unit);
    viewModel.loadContent();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localize.instance.l10n;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (_, __) {
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
                        onChanged: viewModel.updateSearch,
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
                            onTap: () => viewModel.updateFiterOption(filter),
                            child: FilterOption(
                              filterOption: filter,
                              isSelected: viewModel.isFilterOptionSelected(filter),
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
                  sliver: _bodyWidget(context, l10n),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bodyWidget(BuildContext context, Localization l10n) {
    if (viewModel.viewState.isLoading) {
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

    if (viewModel.viewState.hasError) {
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
              onPressed: viewModel.loadContent,
              child: Text(
                l10n.assetTreeTryAgainButton,
                style: context.headlineSmall?.copyWith(color: AppColors.backgroundColor),
              ),
            ),
          ),
        ],
      );
    }

    if (viewModel.baseItems.isEmpty && viewModel.search.isEmpty) {
      return DefaultSliverEmptyMessage(
        message: l10n.assetTreeEmptyResultLabel,
      );
    }

    if (viewModel.baseItems.isEmpty) {
      return DefaultSliverEmptyMessage(
        message: l10n.assetTreeEmptySearchLabel,
      );
    }

    return SliverList.separated(
      itemCount: viewModel.baseItems.length,
      itemBuilder: (_, index) {
        return ExpandableTile(
          baseItem: viewModel.baseItems[index],
          search: viewModel.search,
          isAssetPathExpanded: viewModel.isAssetPathExpanded,
          filterOption: viewModel.filterOption,
        );
      },
      separatorBuilder: (_, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
