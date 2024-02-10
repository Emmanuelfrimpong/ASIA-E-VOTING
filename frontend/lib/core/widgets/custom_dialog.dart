import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:frontend/config/responsiveness/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/styles.dart';

enum ToastType { success, error, warning, info }

class MyDialog {
  BuildContext context;
  String? title;
  String message;
  String? confirmButtonText;
  String? otherButtonText;
  VoidCallback? confirmButtonPress;
  VoidCallback? otherButtonPress;
  MyDialog({
    required this.context,
    required this.title,
    required this.message,
    this.confirmButtonText,
    this.otherButtonText,
    this.confirmButtonPress,
    this.otherButtonPress,
  });

  confirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: Text(title!),
          content: Text(message),
          actions: [
            FilledButton(
              child: Text(confirmButtonText ?? 'Yes'),
              onPressed: () {
                Navigator.pop(context);
                if (confirmButtonPress != null) {
                  confirmButtonPress!.call();
                }
              },
            ),
            OutlinedButton(
              child: Text(otherButtonText ?? 'Cancel'),
              onPressed: () {
                Navigator.pop(context);
                if (otherButtonPress != null) {
                  otherButtonPress!.call();
                }
              },
            ),
          ],
        );
      },
    );
  }

  success() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            title: Row(
              children: [
                Icon(MdiIcons.checkCircle, color: Colors.green),
                Text(title!),
              ],
            ),
            content: Text(message),
            actions: [
              FilledButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  error() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            title: Row(
              children: [
                Icon(
                  MdiIcons.alertBox,
                  color: Colors.red,
                  size: 40,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(title!),
              ],
            ),
            content: Text(message),
            actions: [
              FilledButton(
                child: const Text('Ok'),
                onPressed: () {
                  //close dialog
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  loading() {
    //implement loading
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Text(message),
              ],
            ),
          );
        });
  }

  static toast({
    required String message,
    ToastType type = ToastType.success,
  }) {
    SmartDialog.showToast(
      message,
      alignment:
         Alignment.bottomCenter,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: type == ToastType.success
                ? Colors.green.withOpacity(.1)
                : type == ToastType.error
                    ? Colors.red.withOpacity(.1)
                    : type == ToastType.warning
                        ? Colors.amber.withOpacity(.1)
                        : Colors.blue.withOpacity(.1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            type == ToastType.success
                ? Icons.check_circle
                : type == ToastType.error
                    ? Icons.error
                    : type == ToastType.warning
                        ? Icons.warning
                        : Icons.info,
            color: type == ToastType.success
                ? Colors.green
                : type == ToastType.error
                    ? Colors.red
                    : type == ToastType.warning
                        ? Colors.yellow
                        : Colors.blue,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: getTextStyle(
              color: type == ToastType.success
                  ? Colors.green
                  : type == ToastType.error
                      ? Colors.red
                      : type == ToastType.warning
                          ? Colors.yellow
                          : Colors.blue,
            ),
          ),
        ]),
      ),
    );
  }

  static showCustomDialog({
    required BuildContext context,
    required Widget child,
    String? title,
    double? width,
  }) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(10),
            backgroundColor: Colors.white,
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2)),
            title: Text(
              title ?? '',
              style: getTextStyle(weight: FontWeight.bold),
            ),
            content: SizedBox(
                width: width ?? (ResponsiveUI(context: context).isDesktop()
                    ? size.width * 0.5
                    : ResponsiveUI(context: context).isMobile()
                        ? size.width
                        : size.width * .75),
                child: child),
            actions: [
              //close
              FilledButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  closeLoading() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
