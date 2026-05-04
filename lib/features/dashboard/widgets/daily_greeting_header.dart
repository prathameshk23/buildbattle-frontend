import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/constants/quotes.dart';

class DailyGreetingHeader extends StatelessWidget {
  const DailyGreetingHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final quotes = [...starWarsInspiredQuotes, ...onePieceInspiredQuotes];
    final quote = quotes[Random(DateTime.now().day).nextInt(quotes.length)];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning, $name.', style: AppTextStyles.displaySub),
              const SizedBox(height: 6),
              Text(
                quote,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.backgroundElevated,
              child: Text((name.isEmpty ? '?' : name[0]).toUpperCase()),
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat('MMM d').format(DateTime.now()),
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ],
    );
  }
}
