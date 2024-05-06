import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String noteCategory;
  final int noOfNotes;
  const NotesCard({
    super.key,
    required this.noteCategory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteCategory,
            style: AppTextStyles.appSubtitle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$noOfNotes notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
