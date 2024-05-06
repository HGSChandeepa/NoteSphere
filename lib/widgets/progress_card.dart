import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressCard extends StatefulWidget {
  final int completedTasks;
  final int totalTasks;

  const ProgressCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubtitle.copyWith(
                  color: AppColors.kWhiteColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You have completed ${widget.completedTasks} out of ${widget.totalTasks} tasks, \nkeep up the progress!",
                style: AppTextStyles.appDescriptionSmall.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: AppColors().kPrimaryGradient,
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      ),
    );
  }
}
