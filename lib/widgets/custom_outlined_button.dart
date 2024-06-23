import 'package:flutter/material.dart';

import '../core/app_export.dart';
import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton(
      {super.key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label,
      super.onPressed,
      super.buttonStyle,
      super.buttonTextStyle,
      super.isDisabled,
      super.alignment,
      super.height,
      super.width,
      super.margin,
      required super.text});

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget)
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: height ?? 28.v,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle?.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                return decoration?.color ?? Colors.transparent;
              },
            ),
          ),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style:
                    buttonTextStyle ?? CustomTextStyles.labelMediumBluegray900,
              ),
              rightIcon ?? const SizedBox.shrink()
            ],
          ),
        ),
      );
}
