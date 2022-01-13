import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_fm_audio_management/core/themes/text_styles.dart';



///
/// This is implemented to show the users Dialog alerts
/// base on the platform they are using whether Android
/// or Ios .
///



abstract class PlatformWidget extends StatelessWidget {
  Widget buildCupertinoWidget (BuildContext context);
  Widget buildMaterialWidget (BuildContext context);


  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    }else{
      return buildMaterialWidget(context);
    }
  }
}

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog({required this.title, required this.content, required this.cancelActionText, required this.defaultActionText, required this.textDirection});
  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;
  final TextDirection textDirection;



  Future<bool?> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
      context: context, builder: (context) => this,)
        : await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => this, // 'this' is used for object currently is being used which is platformAlertDialog
    );

  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(

      title: Text(title,style:AppTextStyles.platformAlertTitleTextStyle,),
      content: Text(content,style: AppTextStyles.screenHeader2TextStyle,),
      actions: _buildAction(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(

        title: Text(title,style: AppTextStyles.platformAlertTitleTextStyle,),
        content: Text(content,style: AppTextStyles.screenHeader2TextStyle,),
        actions: _buildAction(context));
  }

  List<Widget> _buildAction(BuildContext context) {
    final actions = <Widget>[];
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressed: () => Navigator.of(context).pop(false),
        ),

      );

    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;


  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      child: child,
      onPressed: onPressed,
    );
  }

}