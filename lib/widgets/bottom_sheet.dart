import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final bool showCategoryInput;
  final Function() onClose;
  final Function() onToggle;

  const CategoryInputBottomSheet({
    required this.showCategoryInput,
    required this.onClose,
    required this.onToggle,
  });

  @override
  _CategoryInputBottomSheetState createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          if (widget.showCategoryInput)
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                hintText: 'Enter Category Name',
              ),
            )
          else
            GestureDetector(
              onTap: widget.onClose,
              child: Row(
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
          if (!widget.showCategoryInput)
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.2),
            ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: widget.onToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.showCategoryInput
                      ? 'Cancel Category Creation'
                      : 'Create New Note Category',
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
