import 'package:flutter/material.dart';
import 'package:vsa/themes/theme.dart';

enum VSAButtonType {
  /// The primary style of the button.
  primary,

  /// The secondary style of the button.
  secondary,
}

class VSAButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool enabled;
  final VSAButtonType type;
  final EdgeInsetsGeometry padding; 

  const VSAButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.enabled = true,
    this.type = VSAButtonType.primary,
    this.padding = AppEdges.noneAll,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = Padding(
      padding: padding,
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.button.copyWith(color: _getTextColor),
        textAlign: TextAlign.center,
      ),
    );

    return FlatButton(
      onPressed: enabled ? onPressed : null,
      color: _getBackgroundColor,
      disabledColor: AppColors.transparent,
      shape: AppBorders.bezel,
      child: label,
    );
  }

  Color get _getBackgroundColor {
    if (!enabled) {
      return AppColors.transparent;
    }

    switch (type) {
      case VSAButtonType.primary:
        return AppColors.blue;
      case VSAButtonType.secondary:
        return AppColors.transparent;
    }

    assert(false);
    return null;
  }

  Color get _getTextColor {
    if (!enabled) {
      return AppColors.darkGray;
    }

    switch (type) {
      case VSAButtonType.primary:
        return AppColors.white;
      case VSAButtonType.secondary:
        return AppColors.blue;
    }

    assert(false);
    return null;
  }
}