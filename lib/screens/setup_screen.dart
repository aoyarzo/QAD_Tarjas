import 'package:flutter/material.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:qad_tarjas/widgets/drawer_widget.dart';

class SetupScreen extends StatelessWidget {
  final _controllerDominio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controllerDominio.text = Preferences.dominio;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Setup',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )),
      drawer: DrawerMenuWidget(),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        //color: Colors.red,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      //color: Colors.green,

                      height: 80,
                      alignment: Alignment.centerLeft,
                      //color: Colors.green,
                      child: Text('Dominio:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal)),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.blue,

                      height: 80,
                      alignment: Alignment.center,
                      //color: Colors.green,
                      child: _TextFieldDominio(_controllerDominio),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            MaterialButton(
              onPressed: () {
                Preferences.dominio = _controllerDominio.text;
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Color(0xFF5A87C6),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text('Guardar',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField _TextFieldDominio(TextEditingController _controllerDominio) {
  return TextFormField(
    controller: _controllerDominio,
    //initialValue: Preferences.dominio,
    autocorrect: false,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      //fillColor: Colors.grey[300],
      //filled: true,
      //labelText: Preferences.dominio,
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
    //onChanged: (value) => clienteForm.clt_prv = value,
  );
}

Future<String?> showDialogResult(BuildContext context) async {
  return showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Dominio Actualizado Correctamente'),
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
