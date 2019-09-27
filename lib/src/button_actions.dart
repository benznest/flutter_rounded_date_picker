import 'package:flutter/material.dart';

class ButtonActions extends StatelessWidget {
  final String negativeBtn;
  final VoidCallback onNegative;
  final String positiveBtn;
  final VoidCallback onPositive;
  final String leftBtn;
  final VoidCallback onLeftBtn;
  final TextStyle textStyle;
  final MaterialLocalizations localizations;

  const ButtonActions({
    Key key,
    this.negativeBtn,
    @required this.onNegative,
    this.positiveBtn,
    @required this.onPositive,
    this.leftBtn,
    this.onLeftBtn,
    @required this.textStyle,
    @required this.localizations,
  }) : super(key: key);

  List<Widget> _buildActionsBtn(bool isLeftBtn) {
    final Widget leftButton = isLeftBtn
        ? FlatButton(
            child: Text(leftBtn, style: textStyle),
            onPressed: onLeftBtn,
          )
        : null;

    final Widget negativeButton = FlatButton(
      child: Text(
        negativeBtn ?? localizations.cancelButtonLabel,
        style: textStyle,
      ),
      onPressed: onNegative,
    );

    final Widget positiveButton = FlatButton(
      child: Text(
        positiveBtn ?? localizations.okButtonLabel,
        style: textStyle,
      ),
      onPressed: onPositive,
    );

    if (isLeftBtn) {
      return [
        leftButton,
        Row(children: <Widget>[negativeButton, positiveButton])
      ];
    }

    return [negativeButton, positiveButton];
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: leftBtn != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: _buildActionsBtn(leftBtn != null),
    );
  }
}
