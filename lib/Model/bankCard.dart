import 'package:hive/hive.dart';

part 'bankCard.g.dart';

@HiveType(typeId: 3)
class BankCard {
  @HiveField(0)
  String name;
  @HiveField(1)
  String shaba;
  @HiveField(2)
  String number;
  @HiveField(3)
  int password;
  @HiveField(4)
  String date;
  @HiveField(5)
  int color;
  @HiveField(6)
  bool numberVisibility;
  @HiveField(7)
  String accountNumber;
  @HiveField(8)
  String description;
  @HiveField(9)
  bool favorite = false;

  BankCard(
      this.name,
      this.shaba,
      this.number,
      this.password,
      this.date,
      this.color,
      this.numberVisibility,
      this.accountNumber,
      this.description,
      this.favorite);

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'shaba' : shaba,
      'number' : number,
      'password' : password,
      'date' : date,
      'color' : color,
      'numberVisibility' : numberVisibility,
      'accountNumber' : accountNumber,
      'description' : description,
      'favorite' : favorite,
    };
  }

  static BankCard fromJson(Map<String, dynamic> data) {
    return BankCard(
        data['name'],
        data['shaba'],
        data['number'],
        data['password'],
        data['date'],
        data['color'],
        data['numberVisibility'],
        data['accountNumber'],
        data['description'],
        data['favorite']);
  }
}
