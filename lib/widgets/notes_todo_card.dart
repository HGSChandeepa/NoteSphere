import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NotesTodoCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  const NotesTodoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<NotesTodoCard> createState() => _NotesTodoCardState();
}

class _NotesTodoCardState extends State<NotesTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: AppTextStyles.appDescription,
            ),
            const SizedBox(height: 2),
            Text(
              widget.description,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
