import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final ToDo toDo;
  final bool isComplete;
  final Function() onCheckBoxChanged;
  const TodoCard({
    super.key,
    required this.toDo,
    required this.isComplete,
    required this.onCheckBoxChanged,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          widget.toDo.title,
          style: AppTextStyles.appDescription,
        ),
        subtitle: Row(
          children: [
            Text(
              '${widget.toDo.date.day}/${widget.toDo.date.month}/${widget.toDo.date.year}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${widget.toDo.time.hour}:${widget.toDo.time.minute}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isComplete,
          onChanged: (bool? value) => widget.onCheckBoxChanged(),
        ),
      ),
    );
  }
}
