import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class ErrorData extends StatelessWidget {
  const ErrorData({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            ImagesConstant.errorIcons,
            scale: 3,
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            'Failed to get data :( please check your connection and reopen the app',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
