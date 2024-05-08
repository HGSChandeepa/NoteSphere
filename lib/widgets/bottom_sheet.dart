import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;

  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryInputBottomSheetState createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.kCardColor,
      ),
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: widget.onNewNote,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create a New Note',
                  style: AppTextStyles.appDescription,
                ),
                Icon(
                  Icons.arrow_right_outlined,
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Divider(
            color: AppColors.kWhiteColor.withOpacity(0.3),
            thickness: 1,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: widget.onNewCategory,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create New Note Category',
                  style: AppTextStyles.appDescription,
                ),
                Icon(
                  Icons.arrow_right_outlined,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
