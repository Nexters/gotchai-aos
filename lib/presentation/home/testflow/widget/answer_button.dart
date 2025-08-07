import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';

enum AnswerButtonType { none, selected, unselected }

class AnswerButton extends StatefulWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? width;
  final AnswerButtonType type;

  const AnswerButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.padding,
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
        padding: widget.padding,
        decoration: BoxDecoration(
          color: switch (widget.type) {
            AnswerButtonType.none => Color.fromRGBO(255, 255, 255, 0.15),
            AnswerButtonType.selected => Color.fromRGBO(191, 255, 0, 0.15),
            AnswerButtonType.unselected => Color.fromRGBO(255, 255, 255, 0.05)
          },
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Container(
            margin: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: switch (widget.type) {
                  AnswerButtonType.none => Colors.transparent,
                  AnswerButtonType.selected => GotchaiColorStyles.primary400,
                  AnswerButtonType.unselected => Colors.transparent
                },
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(9.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: widget.type == AnswerButtonType.unselected
                        ? 0.3
                        : 1.0, // 0.0 (완전 투명) ~ 1.0 (완전 불투명)
                    child: Image.asset(
                      widget.icon,
                      width: 14.w,
                      height: 14.w,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
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
