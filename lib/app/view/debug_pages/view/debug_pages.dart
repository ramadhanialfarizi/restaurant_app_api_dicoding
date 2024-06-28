import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/debug_pages/view_model/debug_pages_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';

class DebugPages extends StatelessWidget {
  const DebugPages({super.key});

  static const String routes = '/debugMode';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DebugPagesProvider(),
      child: const _DebugPagesBuilder(),
    );
  }
}

class _DebugPagesBuilder extends StatelessWidget {
  const _DebugPagesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var _controller = context.read<DebugPagesProvider>();
    return BaseWidgetContainer(
      appBar: BaseAppBar.baseAppBar(
        context,
        title: const Text("Developer Mode"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _controller.testPushNotif(context);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    ColorsConstant.primaryColors,
                  ),
                ),
                child: const Text(
                  'Test Push Notification',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
