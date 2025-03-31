import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class DrawerMenuWidget extends StatefulWidget {


  const DrawerMenuWidget({Key? key}) : super(key: key);
  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {

  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    //final fundosApi = Provider.of<FundosServices>(context);
    return Drawer(
      child: Container(
        color: Color(0xFFE5E7EC),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE5E7EC),
              ),
              child: Column(
                //ScrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin_rounded, color: Color(0xFF5A87C6)),
                      SizedBox(width: 10),
                      Text(
                        Preferences.user,
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF5A87C6)),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green),                    
                      SizedBox(width: 10),
                      Text('Conectado')         
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              title: Text('Sincronizar', style: TextStyle(fontSize: 16)),
              leading: Icon(
                Icons.sync_outlined,
                color: Color(0xFF5A87C6),
              ),
            ),
            ListTile(
              onTap: () {
                dbProvider.cargarTarjas(Preferences.dominio);
                Navigator.pushReplacementNamed(context, 'tarja');
              },
              title: Text('Tarjas', style: TextStyle(fontSize: 16)),
              leading: Icon(
                Icons.app_registration_rounded,
                color: Color(0xFF5A87C6),
              ),
            ),
            ListTile(
              onTap: () {
                dbProvider.cargarTarjas(Preferences.dominio);
                Navigator.pushReplacementNamed(context, 'historial');
              },
              title: Text('Historial', style: TextStyle(fontSize: 16)),
              leading: Icon(
                Icons.history_rounded,
                color: Color(0xFF5A87C6),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'login');
                 Preferences.inicio = 'logout';
              },
              title: Text('Cerrar Sesión', style: TextStyle(fontSize: 16)),
              leading: Icon(
                Icons.logout_rounded,
                color: Color(0xFF5A87C6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
