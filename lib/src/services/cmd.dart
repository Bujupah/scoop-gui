import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shell/shell.dart';
import 'package:windows_app_manager/src/models/Application.dart';
import 'package:windows_app_manager/src/utils/commands.dart';
import 'package:windows_app_manager/src/utils/utils.dart';

class Scoop {
  static bool installed = false;
  static Future<void> scoopCheck() async {
    if( Scoop.installed ) return;
    final _r = await shell.run('scoop', []);

    if(!_r.exitCode.isFine) {
      final __r = await shell.run('start', ['powershell', ...GET_SCOOP]);
      print(__r.stdout);
    }

    Scoop.installed = true;
    return;
  }

  static Future<void> scoopAddBucket(String query) async {
    final _r = await shell.run('scoop', query.bucket.split(' '));
    if(!_r.exitCode.isFine) {
      print(_r.stderr);
    }
    return;
  }

  static Future<void> scoopInstall(String query) async {
    final _r = await shell.run('scoop', query.install.split(' '));
    if(!_r.exitCode.isFine) {
      // Todo: show error dialog
      print(_r.stderr);
    }
    print(_r.stdout);
    return;
  }

  static Future<void> scoopUninstall() async {
    final _r = await shell.run('scoop', []);
    if(!_r.exitCode.isFine) {
      // Todo: show error dialog
    }
    return;
  }

  static Future<List<Application>> scoopList({String query = ''}) async {
    final _r = await shell.run('scoop', query.search.split(' '));
    if(!_r.exitCode.isFine) {
      print('Couldnt run the cammand!');
      Utils.openDialog(AlertDialog(title: Text(_r.stderr)), dismissable: true);
      return [];
    }
    if(_r.stdout != null) {
      if(_r.stdout.toString().isEmpty) return [];
      if(_r.stdout.toString().contains('No matches found.')) return []; 
      if(_r.stdout.toString().contains('other')) {
        // Todo: show popup to tell that there is a known bucket contains the desired app.
        // Get.dialog(AddBucket(
        //   message: _r.stdout.toString(),
        //   onTap: () {
        //     // Extract bucket name from cli result
        //     // scoopAddBucket('');
        //   },
        // ));
        return [];
      }
      List<String> _extract = _r.stdout.toString().split('\n');
      String bucket = '';
      List<Application> _transform = [];
      for (var item in _extract.sublist(0, _extract.length - 2)) {
        if(item.contains('\' bucket')) {
          bucket = item.substring(0, item.length - 1);
        } else if(item.trim().isNotEmpty && !item.trim().isBlank) {
          final _e = item.trim().split(' ');
          final _n = _e.first;
          final _v = _e.sublist(1).join(' ');
          _transform.add(Application(
            name: _n,
            version: _v,
            bucket: bucket
          ));
        }
      }

      print('GOOD?');
      
      return _transform;
    } else return [];
  }

  static void scoopTest({Function(String) callback}) async {
    callback(Platform.localHostname + "\$\n");
    final res = await shell.start('scoop', ['search', 'dart']);
    res.stdout.listen((event) {
      callback(String.fromCharCodes(event));
    });
  }
}

Shell shell = Shell();