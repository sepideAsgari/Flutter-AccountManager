import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';

import '../Model/account.dart';
import '../Model/bankCard.dart';

typedef OnConfirm = Function();
typedef OnError = Function();

class BackUp {
  static final key =
      Key.fromBase64('Kfi0JlA7TLUac/I8vyjJHYQoLPKaONqNri5yBATbEzU=');
  static final iv = IV.fromBase64('sDcIxJRP5mbC0rY69gsfnw==');
  static final encrypter = Encrypter(AES(key));

  static init() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      print(selectedDirectory.toString());
      String time =
          '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';
      File file = File('$selectedDirectory/backup_$time.txt');
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  static Future<String?> getExternalStorage() async {
    return await FilePicker.platform.getDirectoryPath();
  }

  static backUp(OnConfirm onConfirm, OnError onError) async {

    String time = '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

    Box account = Hive.box<Account>('accountList');
    Box bank = Hive.box<BankCard>('bankCardList');

    List<String> accountList = [];
    List<String> cartBankList = [];

    for (int i = 0; i < account.length; i++) {
      Account ac = account.getAt(i);
      accountList.add(json.encode(ac.toMap()));
    }

    for (int i = 0; i < bank.length; i++) {
      BankCard bk = bank.getAt(i);
      cartBankList.add(json.encode(bk.toMap()));
    }

    String? selectedDirectory = await getExternalStorage();

    if (accountList.isNotEmpty || cartBankList.isNotEmpty) {
      Map<String, dynamic> backUpData = {};
      backUpData['time'] = time;
      backUpData['accounts'] = json.encode(accountList);
      backUpData['bankCard'] = json.encode(cartBankList);

      if (selectedDirectory != null) {
        File file = File('$selectedDirectory/backup.txt');
        file.writeAsString(json.encode(backUpData));
      } else {
        onError.call();
      }
    }else{
      onError.call();
    }

  }

  static loadBackUp(OnConfirm onConfirm, OnError onError) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
      allowMultiple: false,
    );

    Box account = Hive.box<Account>('accountList');
    Box bank = Hive.box<BankCard>('bankCardList');

    if (result != null) {
      File file = File(result.files.single.path!);
      String backupJson = await file.readAsString();
      if(backupJson.startsWith('{')){
        Map<String, dynamic> map =
        json.decode(backupJson) as Map<String, dynamic>;
        List listAccount = json.decode(map['accounts']);
        List listBankCard = json.decode(map['bankCard']);

        listAccount.map((e) async {
          Account ac = Account.fromJson(json.decode(e.toString()));
          await account.add(ac);
        }).toList();

        listBankCard.map((e) async {
          BankCard bankCard = BankCard.fromJson(json.decode(e.toString()));
          await bank.add(bankCard);
        }).toList();
        onConfirm.call();
      }else{
        onError.call();
      }
    }
  }

// static Account encryptAccount(Account account){
//   account.name = encrypter.encrypt(account.name, iv: iv).base64;
//   account.username = encrypter.encrypt(account.username, iv: iv).base64;
//   account.password = encrypter.encrypt(account.password, iv: iv).base64;
//   account.date = encrypter.encrypt(account.date, iv: iv).base16;
//   return account;
// }
//
// static BankCard encryptBankCard(BankCard bankCard){
//   bankCard.number = encrypter.encrypt(bankCard.number, iv: iv).base16;
//   bankCard.name = encrypter.encrypt(bankCard.name, iv: iv).base16;
//   if(bankCard.shaba.isNotEmpty){
//     bankCard.shaba = encrypter.encrypt(bankCard.shaba, iv: iv).base16;
//   }
//   if(bankCard.accountNumber.isNotEmpty){
//     bankCard.accountNumber = encrypter.encrypt(bankCard.accountNumber, iv: iv).base16;
//   }
//   return bankCard;
// }
//
// static Account decryptAccount(Account account){
//   account.name = encrypter.decrypt64(account.name ,iv: iv);
//   account.username = encrypter.decrypt64(account.username ,iv: iv);
//   account.password = encrypter.decrypt64(account.password ,iv: iv);
//   account.password = encrypter.decrypt64(account.password ,iv: iv);
//   return account;
// }

}
