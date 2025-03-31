import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetalleConsultaScreen extends StatelessWidget {
  
  final TtarjaLocalModel tarja;

  DetalleConsultaScreen({Key? key, required this.tarja}) : super(key: key);

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    var textStyleTituto = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600);
    //var textStyleTituto2 = TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600);
    var textStyleDato = TextStyle(color: Colors.black87, fontSize: 16);
    //String fechaHoy = formatter.format(now);
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(tarja.ttarjaFecha);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MM-yyyy');
    var outputDate = outputFormat.format(inputDate);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Detalle Tarja',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            leading: IconButton(
                padding: EdgeInsets.only(left: 5),
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, 'tarja');
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_outlined, size: 26)),
            actions: [
              tarja.ttarjaEstado == 'Pendiente' ?

              IconButton(onPressed: () {
                _showDialogConfirmDelete(context, dbProvider, tarja.ttarjaDomain, tarja.ttarjaFundo, 
                tarja.ttarjaLinea, tarja.ttarjaFecha);

              }, icon: Icon(Icons.delete_forever_rounded, size: 30, color: Colors.red,))
              : Container()
            ],
          )
          ),
          body: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: double.infinity,
            height: double.infinity,
            //color: Colors.red,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      //color: Colors.red,
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text('Linea:', style: textStyleTituto)),
                    Text(tarja.ttarjaLinea.toString(), style: textStyleDato),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text('Fecha:', style: textStyleTituto)),
                    Text(outputDate, style: textStyleDato),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text('Estado:', style: textStyleTituto)),
                    Text(tarja.ttarjaEstado, style: textStyleDato),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      //height: 40,
                      child: Text('Empleado:', style: textStyleTituto)),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      //height: 40,
                      child: Text(tarja.ttarjaEmpleado, style: textStyleDato)),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //height: 40,
                        child: Text(tarja.ttarjaEmpleadoNombre, style: textStyleDato)),
                    ),    
                      
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      //height: 40,
                      child: Text('Fundo:', style: textStyleTituto)),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      //height: 40,
                      child: Text(tarja.ttarjaFundo, style: textStyleDato)),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        //height: 40,
                        child: Text(tarja.ttarjaFundoNombre, style: textStyleDato)),
                    ),    
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          //height: 40,
                          child: Text('Operación:', style: textStyleTituto)),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          //height: 40,
                          child: Text(tarja.ttarjaOperacion, style: textStyleDato)),
                    Flexible(
                      child: Container(
                            alignment: Alignment.centerLeft,
                            //height: 40,
                            child: Text(tarja.ttarjaOperacionNombre, style: textStyleDato)),
                    ),  
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      //height: 40,
                      child: Text('Tipo Operación:', style: textStyleTituto)),
                    Text(tarja.ttarjaOpManual == 1 ? 'Manual' : 'Automática', style: textStyleDato),
                  ],
                ),
                    SizedBox(height: 10),
                    Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      //height: 40,
                      child: Text('Cantidad:', style: textStyleTituto)),
                    Text(tarja.ttarjaCantidad.toString(), style: textStyleDato),
                  ],
                ),
                    SizedBox(height: 10),
                    Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      //height: 40,
                      child: Text('UM:', style: textStyleTituto)),
                    Text(tarja.ttarjaOperacionUM, style: textStyleDato),
                  ],
                ),                  
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text('Tipo Pago:', style: textStyleTituto)),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text(tarja.ttarjaPago, style: textStyleDato)),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: Text(tarja.ttarjaPagoNombre, style: textStyleDato)), 
                  ],
                ),
                Row(
                      children: [
                        Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 40,
                      child: Text('Tipo Hora:', style: textStyleTituto)),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 100,
                        height: 40,
                        child: Text(tarja.ttarjaHoraNombre, style: textStyleDato)),

                      Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      width: 100,
                      height: 40,
                      child: Text(tarja.ttarjaHora == 'N'
                      ? 'Jornada:'
                      : tarja.ttarjaHora == 'E'
                      ? 'Hora Extra:'
                      : '', style: textStyleTituto)),
                      Text(
                        tarja.ttarjaHora == 'N'
                      ? tarja.ttarjaJornada.toString()
                      : tarja.ttarjaHora == 'E'
                      ? tarja.ttarjaHextra.toString()
                      : '', style: textStyleDato)

                      ],
                    ),
                
                SizedBox(height: 50),
                tarja.ttarjaOpManual == 1 ?
                Container(
                  child: MaterialButton(
              onPressed: () {
                dbProvider.cargarTDetCuarteles(tarja.ttarjaLinea, Preferences.dominio, tarja.ttarjaFecha);
                Navigator.pushNamed(context, 'cuartelDet');
  
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Color(0xFF5A87C6),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text('Ver Cuarteles',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
                )
                : Container(),
              ],
            ),
          ),

    );
  }
}
Future<String?> _showDialogConfirmDelete(BuildContext context, LocalListProvider dbProvider, 
String dominio, String fundo, int linea, String fecha) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outlined, color: Colors.red),
          SizedBox(height: 10),
          Text('Eliminar Tarja'),
        ],
      ),
      content: const Text('¿Está seguro de que desea eliminar este registro?', textAlign: TextAlign.center),
      actions: <Widget>[
              TextButton(
                  onPressed: () {
                       
                    dbProvider.eliminarTarja(dominio, fundo, fecha, linea);
                    dbProvider.eliminarDetCuarteles(linea);
                    //dbProvider.cargarTarjasHoy(fechaHoy, Preferences.dominio);
                    dbProvider.cargarTarjas(Preferences.dominio);
                    Navigator.pushNamed(context, 'consultar');
                  },
                  child: const Text('Si')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
      ],
    ),
  );
}