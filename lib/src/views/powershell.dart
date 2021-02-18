import 'package:flutter/material.dart';
import 'package:windows_app_manager/src/services/cmd.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/terminal/platform.dart';
import 'package:xterm/terminal/terminal.dart';
import 'package:xterm/theme/terminal_theme.dart';
import 'package:xterm/theme/terminal_themes.dart';

class PowerShell extends StatefulWidget {
  @override
  _PowerShellState createState() => _PowerShellState();
}

class _PowerShellState extends State<PowerShell> {
  final terminal = Terminal(
    platform: PlatformBehaviors.unix,
    theme: TerminalThemes.whiteOnBlack
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Scoop.scoopTest(callback: (value) {
      terminal.write(value);
    });
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