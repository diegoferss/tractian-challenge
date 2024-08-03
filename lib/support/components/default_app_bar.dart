import 'package:flutter/material.dart';
import 'package:tractian/support/extensions/context_extensions.dart';

import '../styles/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double toolbarHeight;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.toolbarHeight = 72,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: AppColors.colorTheme,
      centerTitle: true,
      title: Text(
        title,
        style: context.headlineLarge?.copyWith(color: AppColors.backgroundColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
