import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api_dicoding/app/view/settings/view_model/schedule_provider.dart';

import '../../../../core/global_widget/sidebar.dart';
import '../../../../core/handler/custom_dialog.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({super.key});

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Notification'),
              trailing: Consumer<ScheduleProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledNews(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
