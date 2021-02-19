import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windows_app_manager/src/services/cmd.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/terminal/platform.dart';
import 'package:xterm/terminal/terminal.dart';
import 'package:xterm/theme/terminal_themes.dart';

final terminal = Terminal(
  platform: PlatformBehaviors.unix,
  theme: TerminalThemes.whiteOnBlack
);

class PowerShell extends StatefulWidget {
  final String name;

  const PowerShell({Key key, this.name}) : super(key: key);
  @override
  _PowerShellState createState() => _PowerShellState();
}

class _PowerShellState extends State<PowerShell> {
  @override
  void initState() {
    super.initState();  
    startProcess();
  }

  void startProcess() async {
    if(widget.name == null) return; 
    await Scoop.scoopTestInstall(widget.name, callback: (value) {
      terminal.write(value);
      terminal.setNewLineMode();
    })
    .then((value) => Get.back(result: true))
    .catchError((value) => Get.back(result: false));
    terminal.write('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminal'),
        centerTitle: true,
      ),
      body: TerminalView(
        terminal: terminal,
      ),
    );
  }
}