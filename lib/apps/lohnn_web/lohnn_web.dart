import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'static.dart';

class LohnnWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < constraints.maxHeight)
            return SinglePane();
          else
            return MultiPane();
        },
      ),
    );
  }
}

const _faceAlignment =
    const Alignment(1920 / 2736, (1400 - (2961 / 2)) / (2961 / 2));

class SinglePane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 500,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/Johannes1.jpg",
              alignment: _faceAlignment,
              fit: BoxFit.cover,
            ),
          ),
        ),
        InformationList(),
      ],
    );
  }
}

class MultiPane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1 / 1.5,
          child: Image.asset(
            "assets/images/Johannes1.jpg",
            alignment: _faceAlignment,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              InformationList(),
            ],
          ),
        ),
      ],
    );
  }
}

class InformationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            Title(),
            PhoneNumber(),
            Email(),
            Github(),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Text(
            "Johannes Löhnn",
            style: TextStyle(fontSize: 32),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: QrCode(),
                  contentPadding: EdgeInsets.all(24),
                ),
              );
            },
            child: Image.asset(
              "assets/icons/qrcode.png",
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
//      onTap: () => openLink("tel:076-800 07 61", 'phone'),
      leading: Icon(Icons.phone),
      title: Text("076-800 07 61"),
      subtitle: Text("Personal"),
    );
  }
}

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
//      onTap: () => openLink("mailto:johannes@lohnn.se", 'email'),
      leading: Icon(Icons.mail),
      title: Text("johannes@lohnn.se"),
      subtitle: Text("Personal"),
    );
  }
}

class Github extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
//      onTap: () => openLink("https://github.com/lohnn", 'github'),
      leading: Image.asset(
        "assets/icons/github.png",
        width: 24,
        height: 24,
      ),
      title: Text("Github"),
      subtitle: Text("https://github.com/lohnn"),
    );
  }
}

class QrCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      child: AspectRatio(
        aspectRatio: 1,
        child: QrImage(
          data: vCard,
          version: QrVersions.auto,
          size: 400,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 5,
                )
              ],
              shape: BoxShape.circle,
            ),
            child: ClipOval(child: Image.asset("assets/images/Johannes1.jpg")),
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            'Johannes Löhnn',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}
