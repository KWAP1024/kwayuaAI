// ignore_for_file: unnecessary_null_comparison, unused_label, unused_local_variable

import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "88701e5181b15d3b7ec9eece8ce956732e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "youtube":
        youtube('https://www.youtube.com');
        break;
      case "phonecall":
        phonecall();
        break;
      case "email":
        email();
        break;
      case "sms":
        sms();
        break;
      default:
        debugPrint("unkwon command");
    }
  }

  Future<void> phonecall() async {
    launch('tel:');
  }

  Future<void> email() async {
    launch('mailto:');
  }

  Future<void> sms() async {
    await launch('sms:');
  }

  Future<void> youtube(String _youtubeUrl) async {
    if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
      if (await canLaunch(_youtubeUrl)) {
        final bool _nativeAppLaunchSucceeded = await launch(
          _youtubeUrl,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!_nativeAppLaunchSucceeded) {
          await launch(_youtubeUrl, forceSafariVC: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WELCOME'),
      ),
      body: Center(),
    );
  }
}
