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
    return Dialog(
      insetPadding: EdgeInsets.only(bottom: 300),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: downloading ? [] : [
                  MaterialButton(
                    minWidth: 140,
                    height: 42,
                    child: Text('Cancel'),
                    onPressed: () => Get.back()),
                  MaterialButton(
                    minWidth: 140,
                    height: 42,
                    child: downloading ? CircularProgressIndicator() : Text('Yup!'),
                    onPressed: () async {
                      setState(() { downloading = true; });
                      await widget.onTap?.call();
                      Get.back();
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}