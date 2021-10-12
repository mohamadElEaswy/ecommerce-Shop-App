import 'package:flutter/material.dart';

void navigateAndRemove({required BuildContext context, required String newRouteName}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    newRouteName,
        (Route<dynamic> route) => false,
  );
}


void navigate({required BuildContext context, required String newRouteName, Object? args}) {
  Navigator.pushNamed(
    context,
    newRouteName,
    arguments: args,
  );
}