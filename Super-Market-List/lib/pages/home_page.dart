import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homePage),
      ),
      body: Center(
        child: Text('This is the Home Page'),
      ),
    );
  }
}