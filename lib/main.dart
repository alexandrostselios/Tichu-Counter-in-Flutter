import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info_plus/package_info_plus.dart'; // Import the package
import 'package:provider/provider.dart';
import 'package:test_flutter/pages/help_page.dart'; //Import the Help Page
import 'package:flutter_localizations/flutter_localizations.dart'; // For localization delegates
import 'package:test_flutter/l10n/app_localizations.dart';
import 'package:test_flutter/pages/locale_provider.dart'; // Import your locale provider
import 'package:test_flutter/pages/language_selection_page.dart'; // Import your locale provider

//simple comment

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tichu Counter',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Tichu Counter in Flutter'),
          locale: languageProvider.locale, // Use the locale from the provider
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('el', ''),
          ],
        );
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _team1Tichu1 = false;
  bool _team1Tichu2 = false;
  bool _team1GrandTichu1 = false;
  bool _team1GrandTichu2 = false;
  bool _team2Tichu1 = false;
  bool _team2Tichu2 = false;
  bool _team2GrandTichu1 = false;
  bool _team2GrandTichu2 = false;
  bool _team1TichuOrGrandTichuWon1 = false;
  bool _team1TichuOrGrandTichuWon2 = false;
  bool _team2TichuOrGrandTichuWon1 = false;
  bool _team2TichuOrGrandTichuWon2 = false;

  final TextEditingController _team1Controller = TextEditingController(); //For debug purposes
  final TextEditingController _team2Controller = TextEditingController(); //For debug purposes
  final TextEditingController _team1TotalScoreController = TextEditingController();
  final TextEditingController _team2TotalScoreController = TextEditingController();

  // Add controllers for each player
  final TextEditingController _player1Controller = TextEditingController(text: 'Player 1');
  final TextEditingController _player2Controller = TextEditingController(text: 'Player 2');
  final TextEditingController _player3Controller = TextEditingController(text: 'Player 3');
  final TextEditingController _player4Controller = TextEditingController(text: 'Player 4');

  String _selectedValue = '';
  String _appVersion = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateControllers();
  }

  void _updateControllers() {
    final localizations = AppLocalizations.of(context)!;

    // Update controllers with localized strings
    _player1Controller.text = localizations.player1;
    _player2Controller.text = localizations.player2;
    _player3Controller.text = localizations.player3;
    _player4Controller.text = localizations.player4;
  }

  @override
  void dispose() {
    _team1Controller.dispose();
    _team2Controller.dispose();
    super.dispose();
  }

  void _validateAndSubmitScores() {
    final team1Score = int.tryParse(_team1Controller.text.trim());
    final team2Score = int.tryParse(_team2Controller.text.trim());

    int team1TempScore = 0;
    int team2TempScore = 0;

    if (_team1TichuOrGrandTichuWon1 == true || _team1TichuOrGrandTichuWon2 == true){ //Vgike 1os apo tin omada 1
      // Vgainei 1os o paiktis 1 tis omada 1
      if(_team1TichuOrGrandTichuWon1 == true){
        // Evgale o paiktis 1 to tichu kai o sumpaiktis tou den eipe tipota
        if(_team1TichuOrGrandTichuWon1 == true && _team1Tichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == false){
          team1TempScore = 100;
          print("Tichu o Paiktis 1");
        }else if(_team1TichuOrGrandTichuWon1 == true && _team1GrandTichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == false){
          team1TempScore = 200;
          print("Grand o Paiktis 1");
        }else if(_team1TichuOrGrandTichuWon1 == true && _team1Tichu1 == true && _team1Tichu2 == true && _team1GrandTichu2 == false){
          team1TempScore = 0;
          print("Tichu o Paiktis 1 exase Tichu o Paiktis 4");
        }else if(_team1TichuOrGrandTichuWon1 == true && _team1Tichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == true){
          team1TempScore = 0;
          print("Tichu o Paiktis 1 exase Grand o Paiktis 4");
        }else if(_team1TichuOrGrandTichuWon1 == true && _team1GrandTichu1 == true && _team1Tichu2 == true && _team1GrandTichu2 == false){
          team1TempScore = 100;
          print("Grand o Paiktis 1 exase Tichu o Paiktis 4");
        }else if(_team1TichuOrGrandTichuWon1 == true && _team1GrandTichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == true){
          team1TempScore = 0;
          print("Grand o Paiktis 1 exase Grand o Paiktis 4");
        }
        print(team1TempScore);
      }else if (_team1TichuOrGrandTichuWon2 == true){
        // Evgale o paiktis 1 to tichu kai o sumpaiktis tou den eipe tipota
        if(_team1TichuOrGrandTichuWon2 == true && _team1Tichu2 == true && _team1Tichu1 == false && _team1GrandTichu1 == false){
          team1TempScore = 100;
          print("Tichu o Paiktis 4");
        }else if(_team1TichuOrGrandTichuWon2 == true && _team1GrandTichu2 == true && _team1Tichu1 == false && _team1GrandTichu1 == false){
          team1TempScore = 200;
          print("Grand o Paiktis 4");
        }else if(_team1TichuOrGrandTichuWon2 == true && _team1Tichu2 == true && _team1Tichu1 == true && _team1GrandTichu1 == false){
          team1TempScore = 0;
          print("Tichu o Paiktis 4 exase Tichu o Paiktis 1");
        }else if(_team1TichuOrGrandTichuWon2 == true && _team1Tichu2 == true && _team1Tichu1 == false && _team1GrandTichu1 == true){
          team1TempScore = 0;
          print("Tichu o Paiktis 4 exase Grand o Paiktis 1");
        }else if(_team1TichuOrGrandTichuWon2 == true && _team1GrandTichu2 == true && _team1Tichu1 == true && _team1GrandTichu1 == false){
          team1TempScore = 100;
          print("Grand o Paiktis 4 exase Tichu o Paiktis 1");
        }else if(_team1TichuOrGrandTichuWon2 == true && _team1GrandTichu2 == true && _team1Tichu1 == false && _team1GrandTichu1 == true){
          team1TempScore = 0;
          print("Grand o Paiktis 4 exase Grand o Paiktis 1");
        }
        print(team1TempScore);
      }
      print("Team 1 lost: $team1TempScore");
    }else  if(_team1TichuOrGrandTichuWon1 == false && _team1TichuOrGrandTichuWon2 == false && (_team1Tichu1 == true && _team1Tichu2 == true)){
      team1TempScore = -200;
      print("Team 1 lost: $team1TempScore");
    }else if(_team1TichuOrGrandTichuWon1 == false && _team1TichuOrGrandTichuWon2 == false && ((_team1Tichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == false) || (_team1Tichu1 == false && _team1Tichu2 == true && _team1GrandTichu1 == false))){
      team1TempScore = -100;
      print("Team 1 lost: $team1TempScore");
    }else if(_team1TichuOrGrandTichuWon1 == false && _team1TichuOrGrandTichuWon2 == false && (_team1GrandTichu1 == true && _team1GrandTichu2 == true)){
      team1TempScore = -400;
      print("Team 1 lost: $team1TempScore");
    }else if(_team1TichuOrGrandTichuWon1 == false && _team1TichuOrGrandTichuWon2 == false && ((_team1Tichu1 == true && _team1Tichu2 == false && _team1GrandTichu2 == true) || (_team1Tichu1 == false && _team1Tichu2 == true && _team1GrandTichu1 == true))){
      team1TempScore = -300;
      print("Team 1 lost: $team1TempScore");
    }
    if (_team2TichuOrGrandTichuWon1 == true || _team2TichuOrGrandTichuWon2 == true){
      if(_team2TichuOrGrandTichuWon1 == true){
        if(_team2TichuOrGrandTichuWon1 == true && _team2Tichu1 == true && _team2Tichu2 == false && _team2GrandTichu2 == false){
          team2TempScore = 100;
          print("Tichu o Paiktis 2");
        }else if(_team2TichuOrGrandTichuWon1 == true && _team2GrandTichu1 == true && _team1Tichu2 == false && _team2GrandTichu2 == false){
          team2TempScore = 200;
          print("Grand o Paiktis 2");
        }else if(_team2TichuOrGrandTichuWon1 == true && _team2Tichu1 == true && _team1Tichu2 == true && _team2GrandTichu2 == false){
          team2TempScore = 0;
          print("Tichu o Paiktis 2 exase Tichu o Paiktis 3");
        }else if(_team2TichuOrGrandTichuWon1 == true && _team2Tichu1 == true && _team1Tichu2 == false && _team2GrandTichu2 == true){
          team2TempScore = 0;
          print("Tichu o Paiktis 2 exase Grand o Paiktis 3");
        }else if(_team2TichuOrGrandTichuWon1 == true && _team2GrandTichu1 == true && _team2Tichu2 == true && _team2GrandTichu2 == false){
          team2TempScore = 100;
          print("Grand o Paiktis 2 exase Tichu o Paiktis 3");
        }else if(_team2TichuOrGrandTichuWon1 == true && _team2GrandTichu1 == true && _team2Tichu2 == false && _team2GrandTichu2 == true){
          team2TempScore = 0;
          print("Grand o Paiktis 2 exase Grand o Paiktis 3");
        }
        print(team1TempScore);
      }else if (_team2TichuOrGrandTichuWon2 == true){
        if(_team2TichuOrGrandTichuWon2 == true && _team2Tichu2 == true && _team2Tichu1 == false && _team2GrandTichu1 == false){
          team2TempScore = 100;
          print("Tichu o Paiktis 3");
        }else if(_team2TichuOrGrandTichuWon2 == true && _team2GrandTichu2 == true && _team2Tichu1 == false && _team2GrandTichu1 == false){
          team2TempScore = 200;
          print("Grand o Paiktis 3");
        }else if(_team2TichuOrGrandTichuWon2 == true && _team2Tichu2 == true && _team2Tichu1 == true && _team2GrandTichu1 == false){
          team2TempScore = 0;
          print("Tichu o Paiktis 3 exase Tichu o Paiktis 2");
        }else if(_team2TichuOrGrandTichuWon2 == true && _team2Tichu2 == true && _team2Tichu1 == false && _team2GrandTichu1 == true){
          team2TempScore = 0;
          print("Tichu o Paiktis 3 exase Grand o Paiktis 2");
        }else if(_team2TichuOrGrandTichuWon2 == true && _team2GrandTichu2 == true && _team2Tichu1 == true && _team2GrandTichu1 == false){
          team2TempScore = 100;
          print("Grand o Paiktis 3 exase Tichu o Paiktis 2");
        }else if(_team2TichuOrGrandTichuWon2 == true && _team2GrandTichu2 == true && _team2Tichu1 == false && _team2GrandTichu1 == true){
          team2TempScore = 0;
          print("Grand o Paiktis 3 exase Grand o Paiktis 2");
        }
        print(team2TempScore);
      }
    }else if(_team2TichuOrGrandTichuWon1 == false && _team2TichuOrGrandTichuWon2 == false && (_team2Tichu1 == true && _team2Tichu2 == true)){
      team2TempScore = -200;
      print("Team 2 lost : $team2TempScore");
    }else if(_team2TichuOrGrandTichuWon1 == false && _team2TichuOrGrandTichuWon2 == false && ((_team2Tichu1 == true && _team2Tichu2 == false && _team2GrandTichu2 == false) || (_team2Tichu1 == false && _team2Tichu2 == true && _team2GrandTichu1 == false))){
      team2TempScore = -100;
      print("Team 2 lost : $team2TempScore");
    }else if(_team2TichuOrGrandTichuWon1 == false && _team2TichuOrGrandTichuWon2 == false && (_team2GrandTichu1 == true && _team2GrandTichu2 == true)){
      team2TempScore = -400;
      print("Team 2 lost : $team2TempScore");
    }else if(_team2TichuOrGrandTichuWon1 == false && _team2TichuOrGrandTichuWon2 == false && ((_team2Tichu1 == true && _team2Tichu2 == false && _team2GrandTichu2 == true) || (_team2Tichu1 == false && _team2Tichu2 == true && _team2GrandTichu1 == true))){
      team2TempScore = -300;
      print("Team 2 lost : $team2TempScore");
    }

    if (team1Score != null && team1Score! >= -25 && team1Score! <= 125 && team1Score % 5 == 0 && (team1Score + team2Score!) == 100){
      if (_team1TotalScoreController.text != null && _team1TotalScoreController.text != ''){
        _team1TotalScoreController.text = (int.tryParse(_team1TotalScoreController.text.trim())! + team1Score + team1TempScore).toString();
      }else{
        _team1TotalScoreController.text = (team1Score).toString();
      }
      if (_team2TotalScoreController.text != null && _team2TotalScoreController.text != ''){
        _team2TotalScoreController.text = (int.tryParse(_team2TotalScoreController.text.trim())! + 100 - team1Score + team1TempScore).toString();
      }else{
        _team2TotalScoreController.text = (100 - team1Score).toString();
      }
    }else if (team2Score != null && team2Score! >= -25 && team2Score! <= 125 && team2Score % 5 == 0 && (team1Score! + team2Score) == 100){
      if (_team2TotalScoreController.text != null && _team2TotalScoreController.text != ''){
        _team2TotalScoreController.text = (int.tryParse(_team2TotalScoreController.text.trim())! + team2Score + team2TempScore).toString();
      }else{
        _team2TotalScoreController.text = (team2Score).toString();
      }
      if (_team1TotalScoreController.text != null && _team1TotalScoreController.text != ''){
        _team1TotalScoreController.text = (int.tryParse(_team1TotalScoreController.text.trim())! + 100 - team2Score + team2TempScore).toString();
      }else{
        _team1TotalScoreController.text = (100 - team2Score).toString();
      }
    }else if (team1Score == null || team2Score == null || team1Score % 5 != 0 || team2Score % 5 != 0) {
      _showSnackBar(AppLocalizations.of(context)!.pleaseEnterValidScore);
    } else if (team1Score < -25 || team1Score > 125) {
      _showSnackBar('Team 1 score must be between -25 and 125.');
    } else if (team2Score < -25 || team2Score > 125) {
      _showSnackBar('Team 2 score must be between -25 and 125.');
    } else if ((team1Score + team2Score) <100 || (team1Score + team2Score)>100) {
      _showSnackBar(AppLocalizations.of(context)!.totalScoreMustBe100);
    } else {
      if (_team1TotalScoreController.text != null && _team1TotalScoreController.text != '' && _team2TotalScoreController.text!= null && _team2TotalScoreController.text!= ''){
        _team1TotalScoreController.text = (int.tryParse(_team1TotalScoreController.text.trim())! + team1Score + team1TempScore).toString();
        _team2TotalScoreController.text = (int.tryParse(_team2TotalScoreController.text.trim())! + team2Score + team2TempScore).toString();
      }else{
        _team1TotalScoreController.text = (team1Score + team1TempScore).toString();
        _team2TotalScoreController.text = (team2Score + team2TempScore).toString();
      }
    }
    print(team1TempScore);
    print(team2TempScore);
    _clearRoundScoreFields(false);
  }

  void _clearRoundScoreFields(bool clearAll){
    if(clearAll){
      _team1TotalScoreController.clear();
      _team2TotalScoreController.clear();
      _player1Controller.text = 'Player 1';
      _player2Controller.text = 'Player 2';
      _player3Controller.text = 'Player 3';
      _player4Controller.text = 'Player 4';
    }
    //_team1Controller.text='25';
    //_team2Controller.text='75';
    _team1Controller.clear();
    _team2Controller.clear();
    setState(() {
      _team1Tichu1 = false;
      _team1Tichu2 = false;
      _team1GrandTichu1 = false;
      _team1GrandTichu2 = false;
      _team2Tichu1 = false;
      _team2Tichu2 = false;
      _team2GrandTichu1 = false;
      _team2GrandTichu2 = false;
      _team1TichuOrGrandTichuWon1 = false;
      _team1TichuOrGrandTichuWon2 = false;
      _team2TichuOrGrandTichuWon1 = false;
      _team2TichuOrGrandTichuWon2 = false;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAppVersion(); // Load the app version on initialization
  }

  Future<void> _loadAppVersion() async {
    // Retrieve app version using package_info_plus
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = '${packageInfo.version}'; //(${packageInfo.buildNumber})';
    });
  }

  void _handleMenuSelection(String value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == 'New') {
      // Clear all TextFields when 'Option 1' is selected
      _clearRoundScoreFields(true);
    }else if (value == "Save"){

    }else if (value == "Help"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HelpPage()),
      );
    }else if (value == 'About'){
      // Display app version in a dialog when 'Option 3' is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text(AppLocalizations.of(context)!.about),
            content: Text(AppLocalizations.of(context)!.appVersion + '$_appVersion'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tichu Counter in Flutter"),
        backgroundColor: Colors.deepPurple[100],
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.menu_open_rounded,
                size: 48,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.new_label_rounded),
              title: Text(AppLocalizations.of(context)!.newGame),
              onTap: () => _handleMenuSelection("New"),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: Text(AppLocalizations.of(context)!.save),
              onTap: () => _handleMenuSelection("Save"),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(AppLocalizations.of(context)!.help),
              onTap: () => _handleMenuSelection("Help"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.Language),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(AppLocalizations.of(context)!.about),
              onTap: () => _handleMenuSelection("About"),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(AppLocalizations.of(context)!.totalScore),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Text(AppLocalizations.of(context)!.team1),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _team1TotalScoreController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^-?\d{1,3}$')),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text(AppLocalizations.of(context)!.team2),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _team2TotalScoreController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^-?\d{1,3}$')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20), // Space between the new Row and the Container
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width - 30, // So always have the best visual
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    // Player 1
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _player1Controller,
                              decoration: const InputDecoration(
                                hintText: 'Player 1',
                                icon: Icon(Icons.chair_outlined),
                                contentPadding: EdgeInsets.only(bottom: 0), // No extra padding at the bottom
                              ),
                            ),
                          ),
                          const SizedBox(height: 4), // Space between TextField and Row
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1TichuOrGrandTichuWon1,
                                  checkColor: Colors.red,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1TichuOrGrandTichuWon1 = value ?? false;
                                      if (_team1TichuOrGrandTichuWon1) {
                                        _team1TichuOrGrandTichuWon2 = false; // Uncheck the other checkbox
                                        _team2TichuOrGrandTichuWon1 = false;
                                        _team2TichuOrGrandTichuWon2 = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('W'),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1Tichu1,
                                  checkColor: Colors.red,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1Tichu1 = value ?? false;
                                      if (_team1Tichu1) {
                                        _team1GrandTichu1 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('T'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1GrandTichu1,
                                  checkColor: Colors.red,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1GrandTichu1 = value ?? false;
                                      if (_team1GrandTichu1) {
                                        _team1Tichu1 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('GT'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Player 2
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _player2Controller,
                              decoration: const InputDecoration(
                                hintText: 'Player 2',
                                icon: Icon(Icons.chair),
                                contentPadding: EdgeInsets.only(bottom: 0), // No extra padding at the bottom
                              ),
                            ),
                          ),
                          const SizedBox(height: 4), // Space between TextField and Row
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2TichuOrGrandTichuWon1,
                                  checkColor: Colors.blue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2TichuOrGrandTichuWon1 = value ?? false;
                                      if (_team2TichuOrGrandTichuWon1) {
                                        _team2TichuOrGrandTichuWon2 = false; // Uncheck the other checkbox
                                        _team1TichuOrGrandTichuWon1 = false;
                                        _team1TichuOrGrandTichuWon2 = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('W'),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2Tichu1,
                                  checkColor: Colors.blue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2Tichu1 = value ?? false;
                                      if (_team2Tichu1) {
                                        _team2GrandTichu1 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('T'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2GrandTichu1,
                                  checkColor: Colors.blue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2GrandTichu1 = value ?? false;
                                      if (_team2GrandTichu1) {
                                        _team2Tichu1 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('GT'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Player 3
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _player3Controller,
                              decoration: const InputDecoration(
                                hintText: 'Player 3',
                                icon: Icon(Icons.chair),
                                contentPadding: EdgeInsets.only(bottom: 0), // No extra padding at the bottom
                              ),
                            ),
                          ),
                          const SizedBox(height: 4), // Space between TextField and Row
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2TichuOrGrandTichuWon2,
                                  checkColor: Colors.black,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2TichuOrGrandTichuWon2 = value ?? false;
                                      if (_team2TichuOrGrandTichuWon2) {
                                        _team2TichuOrGrandTichuWon1 = false; // Uncheck the other checkbox
                                        _team1TichuOrGrandTichuWon1 = false;
                                        _team1TichuOrGrandTichuWon2 = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('W'),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2Tichu2,
                                  checkColor: Colors.black,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2Tichu2 = value ?? false;
                                      if (_team2Tichu2) {
                                        _team2GrandTichu2 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('T'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team2GrandTichu2,
                                  checkColor: Colors.black,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team2GrandTichu2 = value ?? false;
                                      if (_team2GrandTichu2) {
                                        _team2Tichu2 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('GT'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Player 4
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextField(
                              controller: _player4Controller,
                              decoration: const InputDecoration(
                                hintText: 'Player 4',
                                icon: Icon(Icons.chair_outlined),
                                contentPadding: EdgeInsets.only(bottom: 0), // No extra padding at the bottom
                              ),
                            ),
                          ),
                          const SizedBox(height: 4), // Space between TextField and Row
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1TichuOrGrandTichuWon2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1TichuOrGrandTichuWon2 = value ?? false;
                                      if (_team1TichuOrGrandTichuWon2) {
                                        _team1TichuOrGrandTichuWon1 = false; // Uncheck the other checkbox
                                        _team2TichuOrGrandTichuWon1 = false;
                                        _team2TichuOrGrandTichuWon2 = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('W'),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1Tichu2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1Tichu2 = value ?? false;
                                      if (_team1Tichu2) {
                                        _team2GrandTichu2 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('T'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _team1GrandTichu2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _team1GrandTichu2 = value ?? false;
                                      if (_team1GrandTichu2) {
                                        _team1Tichu2 = false; // Uncheck the other checkbox
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text('GT'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Center widget for team scores and button
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(AppLocalizations.of(context)!.team1Score),
                                  SizedBox(
                                    width: 100,
                                    child: TextField(
                                      controller: _team1Controller,
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(AppLocalizations.of(context)!.team2Score),
                                  SizedBox(
                                    width: 100,
                                    child: TextField(
                                      controller: _team2Controller,
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _validateAndSubmitScores,
                            child: Text(AppLocalizations.of(context)!.submit),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}