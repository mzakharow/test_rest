import 'package:flutter/material.dart';
import 'package:test_rest/features/home_page/home_page.dart';
import 'package:test_rest/ui/theme/theme.dart';

class TestREST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Request',
      theme: darkTheme,
      home: TestRESTHomePage(),
    );
  }
}