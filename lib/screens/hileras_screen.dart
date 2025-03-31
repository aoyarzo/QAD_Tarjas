import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/screens/screens.dart';
import 'package:provider/provider.dart';

class HilerasScreen extends StatefulWidget {

  @override
  State<HilerasScreen> createState() => _HilerasScreenState();
}

class _HilerasScreenState extends State<HilerasScreen> {

  //final _controllerCodCuartel = TextEditingController();
  final _controllerPorcentaje = TextEditingController();
  //final _controllerCantidad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    final cuarteles = Provider.of<CuartelesProvider>(context);
    //final TarjaProv = Provider.of<TarjaProvider>(context);
    var textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    _controllerPorcentaje.text = '0';

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Selección de Hileras',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            leading: IconButton(
                padding: EdgeInsets.only(left: 5),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pushReplacementNamed(context, 'registrar');
                },
                icon: Icon(Icons.arrow_back_outlined, size: 26)),
          )),
      body: Container(
        //padding: EdgeInsets.only(top: 10),
        //color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(                      
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Código', style: textStyle),
                          ],
                        ),                        
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Nombre', style: textStyle),
                          ],
                        ),                        
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Cantidad', style: textStyle),
                          ],
                        ),
                      ),
                    ),
                    
                    
                  ],
                ),
              ),
            ),
            Expanded(child: Lista_Hileras(cuarteles, dbProvider)),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          
          int  sumaCant = 0;
          for(int i=0; i< dbProvider.hileras.length; i++) {
            if(dbProvider.hileras[i].thileraSelected == 1) {
              sumaCant = dbProvider.hileras[i].thileraCantidad + sumaCant;
            }
          }
          print(sumaCant);
          print(dbProvider.index_selectedCuartel);

          dbProvider.cuarteles[dbProvider.index_selectedCuartel].tcuartelCantidad = sumaCant.toDouble();

          Navigator.pushNamed(context, 'cuarteles');         



        },
        label: Text('Guardar', style: TextStyle(fontSize: 16)),
        backgroundColor: Color(0xFF5A87C6), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  

  ListView Lista_Hileras(CuartelesProvider cuarteles, LocalListProvider dbProvider) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dbProvider.hileras.length,
        //separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          var textStyle2 = TextStyle(color: Colors.black, fontSize: 14);
          return Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: dbProvider.hileras[index].thileraSelected == 0 ? false : true,
                            onChanged: (value) {
                              setState(() {
                                dbProvider.hileras[index].thileraSelected = value! ? 1 : 0;

                             //print(dbProvider.cuarteles[index].tcuartelHilera);
                             print(index);
                              });
                             
          
                            })
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${dbProvider.hileras[index].thileraCodigo}',
                              style: textStyle2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      //color: Colors.grey,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${dbProvider.hileras[index].thileraNombre}',
                              style: textStyle2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.grey,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${dbProvider.hileras[index].thileraCantidad}',
                              style: textStyle2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String?> showDialogResult(BuildContext context, LocalListProvider dbProvider) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Tarja Almacenada Correctamente'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: (context) => RegistrarScreen()
      ), 
     ModalRoute.withName("registrar")
    );
            
     dbProvider.selectedThora = '';
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> showDialogError(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Color(0xFF5A87C6)),
        content: Text('Debe ingresar al menos un Cuartel', textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<String?> showDialogValidate100(BuildContext context) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Icon(Icons.info_outlined, color: Color(0xFF5A87C6)),
        content: Text('La suma de los porcentajes debe ser igual a 100 o 0', textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
}