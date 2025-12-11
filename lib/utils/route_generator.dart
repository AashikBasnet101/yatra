import 'package:flutter/material.dart';
import 'package:newprojectfirebase/main.dart';
import 'package:newprojectfirebase/notifications.dart';
import 'package:newprojectfirebase/utils/routes.dart';

class RouteGenerator {
  static navigateToPage(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(BuildContext context, String route,
      {dynamic arguments}) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.notificationsRoute:
      NotificationsPayload ? payload= settings.arguments as NotificationsPayload?;

        return MaterialPageRoute(builder: (_) =>  Notifications(notificationsPayload: payload,));
        
        default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }}}