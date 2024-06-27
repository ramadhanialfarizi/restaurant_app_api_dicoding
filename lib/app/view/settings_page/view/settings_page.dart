import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/settings_page/view_model/settings_page_provider.dart';
import 'package:restaurant_app_api_dicoding/core/utils/colors_constant.dart';

class SettingPages extends StatelessWidget {
  const SettingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsPageProvider(
        context: context,
      ),
      child: const _SetttingPagesBuilder(),
    );
  }
}

class _SetttingPagesBuilder extends StatelessWidget {
  const _SetttingPagesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.settings,
                size: 35,
                color: ColorsConstant.thirdColors,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Consumer<SettingsPageProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.notificationActive ? 'enable' : 'disable',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer<SettingsPageProvider>(
                builder: (context, value, child) {
                  return Switch(
                    value: value.notificationActive,
                    onChanged: (status) {
                      value.setNotificationSettings(status);
                    },
                    activeColor: ColorsConstant.primaryColors,
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
