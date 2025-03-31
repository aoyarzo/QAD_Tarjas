import 'package:flutter/material.dart';
import 'package:qad_tarjas/models/models.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class ConfiguracionFundoScreen extends StatefulWidget {

  @override
  State<ConfiguracionFundoScreen> createState() => _ConfiguracionFundoScreenState();
}

class _ConfiguracionFundoScreenState extends State<ConfiguracionFundoScreen> {
  final _controllerServidor = TextEditingController();

  final _controllerDominio = TextEditingController();

  final _controllerFundo = TextEditingController();

  final _controllerUser = TextEditingController();

  final _controllerPass = TextEditingController();

  final _controllerBuscar = TextEditingController();

  List<FundoModel> fundos_temp = [];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controllerServidor.text = Preferences.servidor;
    _controllerDominio.text = Preferences.dominio;
    _controllerFundo.text = Preferences.fundo;
    _controllerUser.text = Preferences.usuario;
    _controllerPass.text = Preferences.pass;  
    
    //final valConfig = Provider.of<ValConfigServices>(context);
    final dbProvider = Provider.of<LocalListProvider>(context);
    final fundosApi = Provider.of<FundosServices>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Seleccionar Fundo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
            ),
          )
          ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.red,
                          child: Text('Fundo:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                  
                        )),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                        flex: 3,
                        child: Container(
                          child:
                              _TextFieldFundo(_controllerFundo, dbProvider),
                        ),
                      ),
                      Expanded(
                        //flex: 1,
                        child: Container(
                          child:
                              IconButton(
                                icon: Icon(Icons.search_rounded),
                                iconSize: 35,
                                color: Color(0xFF5A87C6),
                                onPressed: () async {
                                  await fundosApi.getFundos();
                                  _showDialogFundo(context, fundosApi, _controllerBuscar);
                                  fundos_temp = fundosApi.fundos;
                                  //print(TarjaProv.fundo);
                                })
                        ),
                      ),
                            ],
                          )
                        ))
                    ],
                  ),
                ),
                
                SizedBox(height: 50),

                Container(
                  width: 220,
                  child: MaterialButton(
                    onPressed: () async{

                      FocusScope.of(context).unfocus();

                      Navigator.pushNamed(context, 'login');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Color(0xFF5A87C6),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text('Guardar',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFieldServidor(TextEditingController _controllerServidor) {
    return TextFormField(
      controller: _controllerServidor,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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
      //onChanged: (value) => buscarTpago(value, dbProvider),
    );
  }

  TextFormField textFieldDominio(TextEditingController _controllerDominio) {
    return TextFormField(
      controller: _controllerDominio,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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
      //onChanged: (value) => buscarTpago(value, dbProvider),
    );
  }

  TextFormField _TextFieldFundo(
      TextEditingController _controllerFundo, LocalListProvider dbProvider) {
    return TextFormField(
      readOnly: true,
      controller: _controllerFundo,
      //initialValue: Preferences.dominio,
      autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //filled: true,
        //labelText: 'Fundo',
        //errorText: _validateFundo ? 'Campo Vacío' : null,
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
      //onChanged: (value) => buscarFundo(value, dbProvider),
    );
  }

  TextFormField textFieldUser(TextEditingController _controllerUser) {
    return TextFormField(
      controller: _controllerUser,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
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
      //onChanged: (value) => buscarTpago(value, dbProvider),
    );
  }

  TextFormField textFieldContrasena(TextEditingController _controllerPass){
    return TextFormField(
      controller: _controllerPass,
      //obscureText: true,
      //autocorrect: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey[300],
        //labelText: 'Servidor',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<String?> _showDialogFundo(BuildContext context, FundosServices fundosApi, 
  TextEditingController _controllerBuscar) async {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {

      void buscarFundo(String query) {
      final suggestions = fundosApi.fundos.where((tmp) {
      final tempTitle = tmp.siMstrSiDesc.toLowerCase();
      final input = query.toLowerCase();
      return tempTitle.contains(input);
    }).toList();
    setState(() => fundos_temp = suggestions);
  }
  
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Center(child: Text('Fundos')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 65,
                  child: TextFormField(
                controller: _controllerBuscar,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2),
            borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.grey[300],
                  //filled: true,
                  labelText: 'Buscar',
                  //errorText: _validateHextra ? 'Campo Vacío' : null,
                  labelStyle: TextStyle(
            color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 2),
            borderRadius: BorderRadius.circular(10),
                  ),
                ),
          
                onChanged: (value) => setState(() => buscarFundo(value)),
              ),
                ),
                SizedBox(height: 1),
                SizedBox(
                  //width: 100,
                  height: 250,
                  child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 200,
              child: ListView.builder(
                itemCount: fundos_temp.length,
                itemBuilder: (context, index) {
          
                  return Container(
                    color: _selectedIndex == index
                        ? Colors.grey[300]
                        : Colors.white,
                    child: ListTile(
                      leading: Text(fundos_temp[index].siMstrSiSite),
                      
                      title: Text(fundos_temp[index].siMstrSiDesc),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _selectedIndex = index;
                        });
                        _controllerFundo.text = fundos_temp[index].siMstrSiDesc;
                        Preferences.fundo = fundos_temp[index].siMstrSiDesc;
                        Preferences.fundoCod = fundos_temp[index].siMstrSiSite;

                        _controllerBuscar.clear();
                        fundos_temp.clear();
                        
                        Navigator.pop(context);
                        
          
                      },
                    ),
                  );
                },
              ),
            ),
                ),
                MaterialButton(
                  onPressed: () {
                    _controllerBuscar.clear();
                    fundos_temp.clear();
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color(0xFF5A87C6),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Cerrar',
                        style:
                            TextStyle(fontSize: 16, color: Colors.white))
                      )
                 ),
              ],
            ),
          ),
        ),
        );
      }
    );
  }
}