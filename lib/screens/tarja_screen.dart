import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:qad_tarjas/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TarjaScreen extends StatelessWidget {

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  
  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    //final fundosApi = Provider.of<FundosServices>(context);
    String fechaHoy = formatter.format(now);
    print(fechaHoy);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tarjas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          )),
      drawer: DrawerMenuWidget(),
      body: Container(
        //color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //color: Colors.green,
                child: MaterialButton(
                  onPressed: () {
                    print(Preferences.dominio);

                    //dbProvider.cargarFundos(Preferences.dominio);

                    //dbProvider.cargarTpago('a', Preferences.dominio);

                    //dbProvider.cargarOperaciones('a', Preferences.dominio);

                    dbProvider.cargarEmpleados(1, Preferences.dominio);
                    dbProvider.cargarOperaciones(Preferences.fundoCod, Preferences.dominio);                       
                    dbProvider.cargarMaxHEByFundo(Preferences.fundoCod);
            

                    Navigator.pushReplacementNamed(context, 'registrar');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color(0xFF5A87C6),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Registrar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                //color: Colors.green,
                child: MaterialButton(
                  onPressed: () {
                    //dbProvider.cargarTarjasHoy(fechaHoy, Preferences.dominio);
                    dbProvider.cargarTarjas(Preferences.dominio);
                    //dbProvider.cargarAllTDetCuarteles(Preferences.dominio);
                    Navigator.pushReplacementNamed(context, 'consultar');

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color(0xFF5A87C6),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Consultar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
