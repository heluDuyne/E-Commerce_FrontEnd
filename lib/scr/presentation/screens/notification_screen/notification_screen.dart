import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../widgets/notification_item.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Notification'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: const [
            NotificationItem(
              title: 'Good morning! Get 20% Voucher',
              subtitle:
                  'Summer sale up to 20% off. Limited voucher. Get now!! 😜',
            ),
            SizedBox(height: 30),
            NotificationItem(
              title: 'Special offer just for you',
              subtitle: 'New Autumn Collection 30% off',
            ),
            SizedBox(height: 30),
            NotificationItem(
              title: 'Holiday sale 50%',
              subtitle: 'Tap here to get 50% voucher.',
            ),
          ],
        ),
      ),
    );
  }
}
