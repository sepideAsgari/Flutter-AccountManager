import 'package:flutter/cupertino.dart';

class PassPageNotifier extends ChangeNotifier {


  TextEditingController tECSearch = TextEditingController();
  TextEditingController get getTECSearch => tECSearch;

  FocusNode fNSearch = FocusNode();
  FocusNode get getFNSearch => fNSearch;

  int selected = 1;
  int get isSelected => selected;

  PassPageNotifier(){
    tECSearch.addListener(() {
      notify();
    });
    fNSearch.addListener(() {
      notify();
    });
  }

  setSelected(int i){
    selected = i;
    notify();
  }

  notify(){
    Future.delayed(Duration.zero,() {
      notifyListeners();
    },);
  }

}