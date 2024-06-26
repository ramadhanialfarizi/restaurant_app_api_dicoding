import 'package:flutter/material.dart';
import 'package:flutter_package/flutter_package.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/onboarding/view_model/splash_screen_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/image_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String route = "/";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashScreenProvider(
        context: context,
      ),
      child: const _SplashScreenBuilder(),
    );
  }
}

class _SplashScreenBuilder extends StatelessWidget {
  const _SplashScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = context.read<SplashScreenProvider>();
    return BaseWidgetContainer(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            ImagesConstant.icons,
            scale: 3,
          ),
        ),
      ),
    );
  }
}
