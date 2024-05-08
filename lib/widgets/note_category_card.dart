import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NoteCategoryCard extends StatelessWidget {
  final String noteTitle;
  final String noteContent;

  const NoteCategoryCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noteTitle,
              style: AppTextStyles.appSubtitle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              noteContent,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
