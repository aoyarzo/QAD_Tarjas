import 'package:flutter/material.dart';
import 'package:qad_tarjas/local_models/local_models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/screens/detalleConsulta_screen.dart';
import 'package:qad_tarjas/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConsultaScreen extends StatefulWidget {

  @override
  State<ConsultaScreen> createState() => _ConsultaScreenState();
}

class _ConsultaScreenState extends State<ConsultaScreen> {

final _controllerBuscar = TextEditingController();

  List<TtarjaLocalModel> tarjas_temp = [];

  String dropdownValue = 'Fecha';

  final DateTime now = DateTime.now();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter2 = DateFormat('dd MMMM yyyy', 'es_ES');

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    //tarjas_temp = dbProvider.tarjas;
    _controllerBuscar.text.isEmpty ? tarjas_temp = dbProvider.tarjas : [];
    //String fecha = formatter.format(now);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Consultar Tarja',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )),
      drawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Container(
                //color: Colors.red,
                width: double.infinity,
                //height: 100,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Fecha']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                    )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          //color: Colors.blue,
      
                          height: 80,
                          alignment: Alignment.center,
                          //color: Colors.green,
                          child: _TextFieldBuscar(_controllerBuscar, dbProvider),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: IconButton(
                                icon: Icon(Icons.calendar_month_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () {
                                showDatePicker(
                                context: context,
                                locale: Locale('es', ''),
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2030)
                              ).then((value) {
                                setState(() {
                                  String fechaHoy = formatter2.format(value!); //dd MMMM yyyy
                                  String fecha = formatter.format(value); //yyyy-MM-dd
                                  
                                  _controllerBuscar.text = fechaHoy;

                                  buscarEmpleado(fecha, dbProvider);

                                  //TarjaProv.fecha = fecha;
                                  
                                });
                                //print(TarjaProv.fecha);
                                //print(_controllerFecha.text);
                                //final DateTime now = DateTime.now();
                              });
                                }),
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
          var textStyleTituto = TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600);
          var textStyleDato = TextStyle(color: Colors.black87, fontSize: 14);
          DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(tarjas_temp[index].ttarjaFecha);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          return GestureDetector(
            onTap: () {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => 
            //DetalleHistorialScreen(tarja: tarjas_temp[index])
            DetalleConsultaScreen(tarja: tarjas_temp[index])
            ));
          
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: tarjas_temp[index].ttarjaEstado == 'Enviado' ?
                    Color(0xFFFEE4E4) : Color(0xFFDFFBCB), 
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
                                child: Text('Linea:', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                child: Text(tarjas_temp[index].ttarjaLinea.toString())),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                child: Text('Fecha:', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                height: 25,
                                child: Text(outputDate, style: textStyleDato)),
                            ],
                          ),
                        ],
                      ),
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
                                child: Text(tarjas_temp[index].ttarjaEmpleado, style:  textStyleDato)),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  //height: 20,
                                  child: Text(tarjas_temp[index].ttarjaEmpleadoNombre, style:  textStyleDato)),
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
                                child: Text(tarjas_temp[index].ttarjaFundo, style:  textStyleDato)),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  //height: 20,
                                  child: Text(tarjas_temp[index].ttarjaFundoNombre, style:  textStyleDato)),
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
                                child: Text('Operación:', style: textStyleTituto)),
                              Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                width: 80,
                                //color: Colors.green,
                                child: Text(tarjas_temp[index].ttarjaOperacion, style:  textStyleDato)),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  //height: 20,
                                  //color: Colors.blue,
                                  child: Text(tarjas_temp[index].ttarjaOperacionNombre, style:  textStyleDato)),
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
                                child: Text(tarjas_temp[index].ttarjaOpManual == 1 ? 'Manual' : 'Automática', style:  textStyleDato)),
                            ],
                          ),
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
                                child: Text(tarjas_temp[index].ttarjaCantidad.toString(), style:  textStyleDato)),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                child: Text('UM:', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                child: Text(tarjas_temp[index].ttarjaOperacionUM, style:  textStyleDato)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 100,
                                child: Text('Tipo Pago:', style: textStyleTituto)),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                width: 80,
                                child: Text(tarjas_temp[index].ttarjaPago, style:  textStyleDato)),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                child: Text(tarjas_temp[index].ttarjaPagoNombre, style:  textStyleDato)),
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
                                child: Text('Tipo Hora:', style: textStyleTituto)),
                              //SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.green,
                                height: 20,
                                width: 80,
                                child: Text(tarjas_temp[index].ttarjaHoraNombre, style: textStyleDato)),
                              Container(
                                alignment: Alignment.centerLeft,
                                //color: Colors.red,
                                height: 20,
                                child: Text(tarjas_temp[index].ttarjaHora == 'N'
                                ? 'Jornada:'
                                : tarjas_temp[index].ttarjaHora == 'E'
                                ? 'Hora Extra:'
                                : '', style: textStyleTituto)),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 20,
                                child: Text(tarjas_temp[index].ttarjaHora == 'N'
                                ? tarjas_temp[index].ttarjaJornada.toString()
                                : tarjas_temp[index].ttarjaHora == 'E'
                                ? tarjas_temp[index].ttarjaHextra.toString()
                                : '', style: textStyleDato)),
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
                                child: Text(tarjas_temp[index].ttarjaEstado, style:  textStyleDato)),
                            ],
                          ),
                      
                    ],
                  )
                  ),
            ),
          );
        });
  }

  TextFormField _TextFieldBuscar(
      TextEditingController _controllerBuscar, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
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
      //onChanged: (value) => buscarEmpleado(value, dbProvider),
      
      //setState(() => buscarEmpleado(value, dbProvider)),
    );
  }

  void buscarEmpleado(String query, LocalListProvider dbProvider) {
      final suggestions = dbProvider.tarjas.where((tmp) {
      final tempTitle = tmp.ttarjaFecha.toLowerCase();
      final input = query.toLowerCase();
      return tempTitle.startsWith(input);
    }).toList();
    setState(() => tarjas_temp = suggestions);
  }
}
