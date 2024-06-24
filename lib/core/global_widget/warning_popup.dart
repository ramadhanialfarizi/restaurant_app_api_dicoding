import 'package:flutter/material.dart';

import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/constant.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class WarningDialog extends StatelessWidget {
  final String? message;
  final String? activeButtonText;
  final VoidCallback? moreAction;

  final List<Widget>? customAction;
  const WarningDialog({
    super.key,
    this.message = "is not support",
    this.activeButtonText,
    this.customAction,
    this.moreAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Image.asset(
        ImagesConstant.errorIcons,
        width: Constant.getFullWidth(context) * 0.3,
        height: Constant.getFullHeight(context) * 0.2,
        // color: ColorsConstant.primaryColors,
      ),
      titleTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      title: Text(
        message ?? "",
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: customAction ??
          [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                if (moreAction != null) {
                  moreAction!();
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  ColorsConstant.primaryColors,
                ),
              ),
              child: Text(
                activeButtonText ?? "ok",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
    );
  }
}
