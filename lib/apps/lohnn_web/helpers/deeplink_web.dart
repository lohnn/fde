// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

openLink(String link, String name) => html.window.open(link, name);
