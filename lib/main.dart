import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:qad_tarjas/services/services.dart';
import 'package:qad_tarjas/share_preferences/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qad_tarjas/screens/screens.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalListProvider()),
        ChangeNotifierProvider(create: (context) => FundosServices()),
        ChangeNotifierProvider(create: (context) => EmpleadosServices()),
        ChangeNotifierProvider(create: (context) => OperacionesServices()),
        ChangeNotifierProvider(create: (context) => TipoPagoServices()),
        ChangeNotifierProvider(create: (context) => TipoHoraServices()),
        ChangeNotifierProvider(create: (context) => CuartelesServices()),
        ChangeNotifierProvider(create: (context) => HilerasServices()),
        ChangeNotifierProvider(create: (context) => CuartelesProvider()),
        ChangeNotifierProvider(create: (context) => MaxHEServices()),
        ChangeNotifierProvider(create: (context) => TarjaProvider()),
        ChangeNotifierProvider(create: (context) => AuthUserService()),
        ChangeNotifierProvider(create: (context) => ValConfigServices()),

      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Color(0xFF5A87C6)),
          title: 'QAD Tarjas',
          initialRoute: Preferences.inicio == 'login' ? 'home' : 'login',
          //initialRoute: 'home',
          routes: {
            'login': (_) => LoginScreen(),
            'home': (_) => HomeScreen(),
            'tarja': (_) => TarjaScreen(),
            'historial': (_) => HistorialScreen(),
            'setup': (_) => SetupScreen(),
            'registrar': (_) => RegistrarScreen(),
            'cuarteles': (_) => CuartelesScreen(),
            'consultar': (_) => ConsultaScreen(),
            //'detalle': (_) => DetalleScreen(tarja: []),
            'cuartelDet': (_) => CuartelesDetallesScreen(),
            'configuracion': (_) => ConfiguracionScreen(),
            'configuracionFundo': (_) => ConfiguracionFundoScreen(),
            'hilera': (_) => HilerasScreen(),
          },
        ),
      ),
    );
  }
}