import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';

enum AnswerButtonType { none, selected, unselected }

class AnswerButton extends StatefulWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final double? width;
  final AnswerButtonType type;

  const AnswerButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.padding,
    this.width,
    this.type = AnswerButtonType.none,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: switch (widget.type) {
            AnswerButtonType.none => Color.fromRGBO(255, 255, 255, 0.15),
            AnswerButtonType.selected => Color.fromRGBO(191, 255, 0, 0.15),
            AnswerButtonType.unselected => Color.fromRGBO(255, 255, 255, 0.05)
          },
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(
                color: switch (widget.type) {
                  AnswerButtonType.none => Colors.transparent,
                  AnswerButtonType.selected => GotchaiColorStyles.primary400,
                  AnswerButtonType.unselected => Colors.transparent
                },
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Padding(
              padding: widget.padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity:
                        widget.type == AnswerButtonType.unselected ? 0.3 : 1.0,
                    child: Image.asset(
                      widget.icon,
                      width: 32.w,
                      height: 32.w,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(widget.text,
                      style: widget.type == AnswerButtonType.unselected
                          ? GotchaiTextStyles.body4.copyWith(
                              color: Color.fromRGBO(255, 255, 255, 0.3))
                          : GotchaiTextStyles.body4),
                ],
              ),
            )),
      ),
    );
  }
}
