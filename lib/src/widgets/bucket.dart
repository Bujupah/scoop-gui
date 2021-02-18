import 'package:flutter/material.dart';

class GetBucket extends StatefulWidget {
  final String message;
  final Function onTap;

  const GetBucket({Key key, this.message, this.onTap}) : super(key: key);
  @override
  _GetBucketState createState() => _GetBucketState();
}

class _GetBucketState extends State<GetBucket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.message),
            MaterialButton(onPressed: widget.onTap?.call())
          ],
        ),
      ),
    );
  }
}
