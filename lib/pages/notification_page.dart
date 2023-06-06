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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              UIString.NOTFICATION_HEADER,
              style: AppTextStyle.F22_BOLD.copyWith(
                color: AppColors.GREY_DARK,
              ),
            ),
            const SizedBox(height: 5),

            // List of noti tile
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => _getNotiListTile(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getNotiListTile(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            "Notiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
            style: AppTextStyle.F18_BOLD.copyWith(
              color: AppColors.GREY_DARK,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "Notiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
            style: AppTextStyle.F14_NORMAL,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "07:00 PM",
                style: AppTextStyle.F14_NORMAL.copyWith(
                  color: AppColors.GREY_DARK,
                ),
              ),
              Text(
                "2022-02-01",
                style: AppTextStyle.F14_NORMAL.copyWith(
                  color: AppColors.GREY_DARK,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.5,
          color: AppColors.GREY_LIGHT,
        ),
      ],
    );
  }
}
