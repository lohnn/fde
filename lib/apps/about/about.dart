import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headline1 = textTheme.headline.copyWith(fontWeight: FontWeight.w100);
    final headline2 = headline1.copyWith(fontWeight: FontWeight.w500);
    final subhead = textTheme.subhead.copyWith(fontWeight: FontWeight.w100);
    final body = textTheme.body1.copyWith(fontWeight: FontWeight.w300);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Flutter", style: headline1),
                  TextSpan(text: "OS", style: headline2),
                ],
              ),
            ),
            Text("Version 1.0-beta", style: subhead),
            Text(""),
            Text("Powered by Flutter", style: body),
          ],
        ),
      ),
    );
  }
}
