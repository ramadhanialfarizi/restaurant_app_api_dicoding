import 'package:flutter/material.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
            ImagesConstant.emptyIcons,
            scale: 3,
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            'Opps data not found :(',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
