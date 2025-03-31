import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/local_list_provider.dart';
import 'package:qad_tarjas/screens/detalleHistorial_screen.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:qad_tarjas/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistorialScreen extends StatefulWidget {
  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  final _controllerBuscar = TextEditingController();

  List<TtarjaLocalModel> tarjas_temp = [];

  String dropdownValue = 'Empleado';

  //String estado = 'Enviado';

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    //tarjas_temp = dbProvider.tarjas;
    _controllerBuscar.text.isEmpty ? tarjas_temp = dbProvider.tarjas : [];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  'Historial',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          _showDialogCambioEstado(
                              context, tarjas_temp, dbProvider);
                        },
                        icon: Icon(Icons.settings)))
              ],
            ),
          )),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                //color: Colors.red,
                width: double.infinity,
                //height: 100,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      /*decoration: BoxDecoration(
                      //color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38)),*/
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        //icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        //style: const TextStyle(color: Colors.deepPurple),
                        /*underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),*/
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Empleado']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                    Expanded(child: Container()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        //color: Colors.green,
                        height: 60,
                        child: _TextFieldBuscar(_controllerBuscar, dbProvider),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              //color: Colors.red,
              width: double.infinity,
              //height: double.infinity,
              child: Lista_Articulos(),
            ),
          ],
        ),
      ),
    );
  }

  ListView Lista_Articulos() {
    //tarjas_temp = dbProvider.tarjas;
    //buscarEmpleado('', dbProvider);
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tarjas_temp.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          var textStyleTituto = TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600);
          var textStyleDato = TextStyle(color: Colors.black87, fontSize: 14);
          DateTime parseDate = new DateFormat("yyyy-MM-dd")
              .parse(tarjas_temp[index].ttarjaFecha);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetalleHistorialScreen(tarja: tarjas_temp[index])));
              print(tarjas_temp[index].ttarjaServidor);
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: tarjas_temp[index].ttarjaEstado == 'Enviado'
                          ? Color(0xFFFEE4E4)
                          : Color(0xFFDFFBCB),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child:
                                      Text('Linea:', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child: Text(tarjas_temp[index]
                                      .ttarjaLinea
                                      .toString())),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child:
                                      Text('Fecha:', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  child:
                                      Text(outputDate, style: textStyleDato)),
                            ],
                          ),
                          tarjas_temp[index].ttarjaEstado == 'Enviado'
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  height: 25,
                                  child: Checkbox(
                                      value:
                                          tarjas_temp[index].ttarjaSelected == 0
                                              ? false
                                              : true,
                                      onChanged: (value) {
                                        setState(() {
                                          tarjas_temp[index].ttarjaSelected =
                                              value! ? 1 : 0;
                                          print(tarjas_temp[index]
                                              .ttarjaSelected);
                                          //print(value);
                                        });
                                      }),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 100,
                              child: Text('Empleado:', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 80,
                              child: Text(tarjas_temp[index].ttarjaEmpleado,
                                  style: textStyleDato)),
                          Flexible(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                child: Text(
                                    tarjas_temp[index].ttarjaEmpleadoNombre,
                                    style: textStyleDato)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 100,
                              child: Text('Fundo:', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 80,
                              child: Text(tarjas_temp[index].ttarjaFundo,
                                  style: textStyleDato)),
                          Flexible(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                child: Text(
                                    tarjas_temp[index].ttarjaFundoNombre,
                                    style: textStyleDato)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 100,
                              //color: Colors.red,
                              child:
                                  Text('Operación:', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 80,
                              //color: Colors.green,
                              child: Text(tarjas_temp[index].ttarjaOperacion,
                                  style: textStyleDato)),
                          Flexible(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                //color: Colors.blue,
                                child: Text(
                                    tarjas_temp[index].ttarjaOperacionNombre,
                                    style: textStyleDato)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 180,
                              child: Text('', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 80,
                              child: Text(
                                  tarjas_temp[index].ttarjaOpManual == 1
                                      ? 'Manual'
                                      : 'Automática',
                                  style: textStyleDato)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 100,
                              child: Text('Cantidad:', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 80,
                              child: Text(
                                  tarjas_temp[index].ttarjaCantidad.toString(),
                                  style: textStyleDato)),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Text('UM:', style: textStyleTituto)),
                          SizedBox(width: 10),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Text(tarjas_temp[index].ttarjaOperacionUM,
                                  style: textStyleDato)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 100,
                              child:
                                  Text('Tipo Pago:', style: textStyleTituto)),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 80,
                              child: Text(tarjas_temp[index].ttarjaPago,
                                  style: textStyleDato)),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Text(tarjas_temp[index].ttarjaPagoNombre,
                                  style: textStyleDato)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  width: 100,
                                  //color: Colors.blue,
                                  child: Text('Tipo Hora:',
                                      style: textStyleTituto)),
                              //SizedBox(width: 10),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  //color: Colors.green,
                                  height: 20,
                                  width: 80,
                                  child: Text(
                                      tarjas_temp[index].ttarjaHoraNombre,
                                      style: textStyleDato)),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  //color: Colors.red,
                                  height: 20,
                                  child: Text(
                                      tarjas_temp[index].ttarjaHora == 'N'
                                          ? 'Jornada:'
                                          : tarjas_temp[index].ttarjaHora == 'E'
                                              ? 'Hora Extra:'
                                              : '',
                                      style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  height: 20,
                                  child: Text(
                                      tarjas_temp[index].ttarjaHora == 'N'
                                          ? tarjas_temp[index]
                                              .ttarjaJornada
                                              .toString()
                                          : tarjas_temp[index].ttarjaHora == 'E'
                                              ? tarjas_temp[index]
                                                  .ttarjaHextra
                                                  .toString()
                                              : '',
                                      style: textStyleDato)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 25,
                              width: 100,
                              child: Text('Estado:', style: textStyleTituto)),
                          //SizedBox(width: 10),
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 25,
                              child: Text(tarjas_temp[index].ttarjaEstado,
                                  style: textStyleDato)),
                        ],
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  TextFormField _TextFieldBuscar(
      TextEditingController _controllerBuscar, LocalListProvider dbProvider) {
    return TextFormField(
      //readOnly: true,
      controller: _controllerBuscar,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        labelText: 'Buscar',
        //errorText: _validateOp ? 'Campo Vacío' : null,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      /*validator: (value) {
        return (value != null && value.length < 9 && value.length > 0)
            ? null
            : 'Campo Vacío / Máx. 8 Caracteres';
      },*/
      onChanged: (value) => buscarEmpleado(value, dbProvider),

      //setState(() => buscarEmpleado(value, dbProvider)),
    );
  }

  void buscarEmpleado(String query, LocalListProvider dbProvider) {
    final suggestions = dbProvider.tarjas.where((tmp) {
      final tempTitle = tmp.ttarjaEmpleadoNombre.toLowerCase();
      final input = query.toLowerCase();
      return tempTitle.startsWith(input);
    }).toList();
    setState(() => tarjas_temp = suggestions);
  }
}

Future<void> _showDialogCambioEstado(BuildContext context,
    List<TtarjaLocalModel> tarjas_temp, LocalListProvider dbProvider) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(Icons.warning_rounded, size: 40, color: Color(0xFF5A87C6)),
              SizedBox(height: 10),
              Text('Por Favor Confirmar', textAlign: TextAlign.center),
            ],
          ),
          content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: '¿Desea Cambiar las Tarjas Seleccionadas a Estado ',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                TextSpan(
                    text: 'Pendiente',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '?',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ])),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  backgroundColor: Color(0xFF5A87C6)),
              child: Text('Confirmar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                for (int i = 0; i < tarjas_temp.length; i++) {
                  if (tarjas_temp[i].ttarjaSelected == 1) {
                    //dbProvider.tarjas[i].ttarjaEstado == 'Pendiente';
                    DBProvider.db.updateTarjaEstado(tarjas_temp[i].ttarjaLinea, 'Pendiente');
                  }
                }
                dbProvider.cargarTarjas(Preferences.dominio);
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  backgroundColor: Colors.grey),
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    },
  );
}


/*    Column(
                  children: [
                    RadioListTile(
                      title: Text("Enviado"),
                      value: "Enviado",
                      groupValue: estado,
                      onChanged: (value) {
                        setState(() {
                          estado = value.toString();
                        });
                        print(value);
                      },
                    ),
                    RadioListTile(
                      title: Text("Pendiente"),
                      value: "Pendiente",
                      groupValue: estado,
                      onChanged: (value) {
                        setState(() {
                          estado = value.toString();
                        });
                        print(value);
                      },
                    ),
                  ],
                ),*/