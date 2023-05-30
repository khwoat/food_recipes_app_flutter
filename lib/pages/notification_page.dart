import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/string.dart';
import '../constants/text_style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ORANGE_FE7455,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          AppString.NOTIFICATION_PAGE,
          textAlign: TextAlign.center,
          style: AppTextStyle.F24_BOLD.copyWith(
            color: AppColors.WHITE,
          ),
        ),
      ),
    );
  }
}
