import 'package:hive/hive.dart';

part 'passHistory.g.dart';

@HiveType(typeId: 1)
class PassHistory extends HiveObject {

  @HiveField(0)
  String password;

  @HiveField(1)
  String date;

  PassHistory(this.password, this.date);

}