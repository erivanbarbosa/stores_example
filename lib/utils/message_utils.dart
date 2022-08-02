import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorMessage(String message) {
  Future.delayed(Duration(milliseconds: 0), () {
    if (message.isNotEmpty) {
      FlushbarHelper.createError(
        message: message,
        title: 'Erro',
        duration: Duration(seconds: 3),
      )..show(Get.context!);
    }
  });

  return SizedBox.shrink();
}

showSuccessMessage() {
  Future.delayed(Duration(milliseconds: 0), () {
    FlushbarHelper.createSuccess(
      message: "Salvo com sucesso",
      title: 'Sucesso',
      duration: Duration(seconds: 3),
    )..show(Get.context!);
  });

  return SizedBox.shrink();
}

showDeleteSuccessMessage() {
  Future.delayed(Duration(milliseconds: 0), () {
    FlushbarHelper.createSuccess(message: "Excluído com sucesso", title: 'Sucesso', duration: Duration(seconds: 3))..show(Get.context!);
  });

  return SizedBox.shrink();
}

Future<void> showAlert(BuildContext context, String title, Widget content, {String? popActionText, List<Widget>? actions, bool changeBack = false}) async {
  List<Widget> alertActions = [];

  if (!changeBack) {
    alertActions.add(FlatButton(
      child: Text((popActionText != null) ? popActionText : 'OK',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ));
  }

  if (actions != null) {
    alertActions.addAll(actions);
  }

  await _showDialog(context, title, content, alertActions);
}

Future<void> _showDialog(BuildContext context, String title, Widget content, List<Widget> alertActions) async {
  await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
                title: Text(
                  title,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                content: content,
                actions: alertActions));
      });
}
