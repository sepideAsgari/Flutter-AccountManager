import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StaticData {

  static List<String> accountIcons = [
    'assets/images/account/adobe.svg',
    'assets/images/account/gmail.svg',
    'assets/images/account/behance.svg',
    'assets/images/account/discord.svg',
    'assets/images/account/dribble.svg',
    'assets/images/account/github.svg',
    'assets/images/account/linkedin.svg',
    'assets/images/account/microsoft.svg',
    'assets/images/account/netflix.svg',
    'assets/images/account/pinterest.svg',
    'assets/images/account/playstation.svg',
    'assets/images/account/reddit.svg',
    'assets/images/account/snapchat.svg',
    'assets/images/account/spotify.svg',
    'assets/images/account/steam.svg',
    'assets/images/account/telegram.svg',
    'assets/images/account/twitch.svg',
    'assets/images/account/whatsapp.svg',
    'assets/images/account/xbox.svg',
    'assets/images/account/xiaomi.svg',
    'assets/images/account/bank.svg',
    'assets/images/account/website.svg',
    'assets/images/account/epicgames.svg',
    'assets/images/account/soundcloud.svg',
    'assets/images/account/games.svg',
    'assets/images/account/instagram.svg',
    'assets/images/account/facebook.svg',
    'assets/images/account/pinterest.svg',
    'assets/images/account/tiktok.svg',
    'assets/images/account/twitter.svg',
    'assets/images/account/supercell.svg',
    'assets/images/account/apple.svg',
    'assets/images/account/activision.svg',
  ];

  static List<Color> accountColors = [
    Colors.black,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.pink,
    Colors.purpleAccent,
    Colors.brown,
    Colors.deepOrange,
    Colors.tealAccent,
    Colors.blueGrey
  ];

  static deleteAccount(Box box, int index){
    Future.delayed(const Duration(milliseconds: 300),() {
      box.deleteAt(index);
    },);
  }

}
