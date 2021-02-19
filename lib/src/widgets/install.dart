import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetInstall extends StatefulWidget {
  final String label;
  final Function onTap;
  const GetInstall({Key key, this.label, this.onTap}) : super(key: key);
  @override
  _GetInstallState createState() => _GetInstallState();
}

class _GetInstallState extends State<GetInstall> {
  bool downloading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 300,
            child: Text(!downloading
              ? 'Would you like to install\n${widget.label} ?'
              : 'Downloading...!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          if(downloading) CircularProgressIndicator()
        ],
      ),
      actions: downloading ? [] : [
        MaterialButton(
          minWidth: 100,
          height: 42,
          child: Text('Cancel'),
          onPressed: () => Get.back()),
        MaterialButton(
          minWidth: 100,
          height: 42,
          child: downloading ? CircularProgressIndicator() : Text('Yup!'),
          onPressed: () async {
            setState(() { downloading = true; });
            await widget.onTap?.call();
            Get.back();
        })
      ],
    );
  }
}