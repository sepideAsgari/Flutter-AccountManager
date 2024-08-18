import 'package:hive/hive.dart';
part 'account.g.dart';

@HiveType(typeId: 2)
class Account {

  @HiveField(0)
  String name;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  @HiveField(3)
  String description;
  @HiveField(4)
  String website;
  @HiveField(5)
  String icon;
  @HiveField(6)
  int color;
  @HiveField(7)
  String date;
  @HiveField(8)
  bool favorite = false;

  Account(this.name, this.username, this.password, this.description,
      this.website, this.icon, this.color, this.date, this.favorite);

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'username' : username,
      'password' : password,
      'description' : description,
      'website' : website,
      'icon' : icon,
      'color' : color,
      'date' : date,
      'favorite' : favorite,
    };
  }

  static Account fromJson (Map<String,dynamic> data){
    return Account(
        data['name'],
        data['username'] ,
        data['password'],
        data['description'],
        data['website'],
        data['icon'],
        data['color'],
        data['date'],
        data['favorite']);
  }

}