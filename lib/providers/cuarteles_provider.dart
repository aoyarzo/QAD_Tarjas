import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/models/models.dart';

class CuartelesProvider with ChangeNotifier {
  List<TDetCuartelLocalModel> cuarteles = [
    //Art(req: 20100088, due_by: '8/5/2021', from: 'User Admin(admin)'),
    //Art(req: 20101728, due_by: '9/27/2021', from: 'aoyarzo'),
  ];

  List<CuartelModel> outputList = [];

  List<TDetCuartelLocalModel> get req {
    return cuarteles;
  }

  set req(List<TDetCuartelLocalModel> cuartel) {
    this.cuarteles = cuartel;

    notifyListeners();
  }

  agregar(TDetCuartelLocalModel data) {
    cuarteles.add(data);
    notifyListeners();
  }

  remover(int index) {
    cuarteles.removeAt(index);
    notifyListeners();
  }

  removeAll() {
    cuarteles.clear();
    notifyListeners();
  }

  List<CuartelModel> getCuartelesByFundoOP(List<CuartelModel> inputlist) {
                    outputList = inputlist.where((o) => o.xxawoMstrXxawoSite == '103').toList();
                    notifyListeners();
                    return outputList;
                    
  }
}