import 'package:flutter/material.dart';
import 'package:qad_tarjas/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CuartelesDetallesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<LocalListProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color(0xFF5A87C6),
            title: Container(
                child: Text(
              'Detalle Cuarteles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            leading: IconButton(
                padding: EdgeInsets.only(left: 5),
                onPressed: () {
                  //Navigator.pushReplacementNamed(context, 'tarja');
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_outlined, size: 26)),
          )),
          
      body: Container(
        //color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Lista_Articulos(dbProvider),
      ),
    );
  }

  ListView Lista_Articulos(LocalListProvider dbProvider) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dbProvider.Detcuarteles.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          var textStyleTituto = TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600);
          var textStyleDato = TextStyle(color: Colors.black87, fontSize: 14);
          DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(dbProvider.Detcuarteles[index].tdetcuartelFecha);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          var outputDate = outputFormat.format(inputDate);
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  //color: Colors.red,
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
                              child: Text(dbProvider.Detcuarteles[index].tdetcuartelLinea.toString())),
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
                              height: 20,
                              width: 110,
                              child: Text('Cuartel:', style: textStyleTituto)),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              width: 80,
                              child: Text(dbProvider.Detcuarteles[index].tdetcuartelCuartel, style:  textStyleDato)),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Text(dbProvider.Detcuarteles[index].tdetcuartelCuartelNombre, style:  textStyleDato)),  
                          ],
                        ),
                    Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 110,
                              child: Text('Fundo:', style: textStyleTituto)),
                            Container(
                              alignment: Alignment.centerLeft,
                              //height: 20,
                              width: 80,
                              child: Text(dbProvider.Detcuarteles[index].tdetcuartelFundo, style:  textStyleDato)),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //height: 20,
                                child: Text(dbProvider.Detcuarteles[index].tdetcuartelFundoNombre, style:  textStyleDato)),
                            ),  
                          ],
                        ),                      
                    Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 25,
                              width: 110,
                              child: Text('Cantidad:', style: textStyleTituto)),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 25,
                              child: Text(dbProvider.Detcuarteles[index].tdetcuartelCantidad.toString(), style:  textStyleDato)),
                          ],
                        ),
                    
                  ],
                )),
          );
        });
  }
}
