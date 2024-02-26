import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:remona/routes/pages.dart';
import 'package:remona/routes/routes.dart';

import 'design/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Remona',
      themeMode: ThemeMode.system,
      theme: RemonaTheme.primary,
      getPages: Pages.routes,
      initialRoute: Routes.home,
    );
  }
}
