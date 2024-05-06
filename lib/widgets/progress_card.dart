import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress',
                    style: AppTextStyles.appSubtitle.copyWith(
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "You have completed ${widget.completedTasks} out of ${widget.totalTasks} tasks, \nkeep up the progress!",
                      style: AppTextStyles.appDescription.copyWith(
                        color: AppColors.kWhiteColor,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
