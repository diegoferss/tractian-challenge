import 'package:flutter/material.dart';
import 'package:tractian/support/extensions/context_extensions.dart';
import 'package:tractian/support/styles/app_colors.dart';

class DefaultSliverEmptyMessage extends StatelessWidget {
  final String message;

  const DefaultSliverEmptyMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        const SizedBox(height: 40),
        const Icon(
          Icons.sentiment_dissatisfied_rounded,
          size: 80,
          color: AppColors.highlightColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Text(
            message,
            style: context.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
