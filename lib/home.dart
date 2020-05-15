import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  String codigoBarras = '';
  String whatsapp = '';
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.title),
      ),

      body: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250.0,
                height: 80.0,
                child: FloatingActionButton.extended(
                  icon: Icon(AntDesign.barcode),
                  label: Text('Scanear Código'),
                  onPressed: () async {
                    var result = await BarcodeScanner.scan();
                    if (result.rawContent != '') {
                      this.codigoBarras = result.rawContent;
                    }
                  },
                ),
              ),
              Form(
                key: _formkey,
                child: Column(children: <Widget>[
                  
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: 'ex: 8299999999',
                        hintStyle: TextStyle(fontSize: 25.0),
                        contentPadding: const EdgeInsets.all(20.0)
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        print(value);
                        return 'Por favor digite um número';
                      }
                      this.whatsapp = '55' + value;
                      return null;
                    },
                  ),
                 
                 RaisedButton(
                    child: Text(
                      "Enviar",
                      style: TextStyle(fontSize: 30.0),
                      ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    onPressed: () async => {
                      if (_formkey.currentState.validate())
                        {
                          if(this.codigoBarras.isEmpty){
                            print('entroui'),
                            Alert(context: context, title: "Nenhum código escaneado").show(),

                          }
                          else{
                            await launch(
                              "https://wa.me/${this.whatsapp}?text=${this.codigoBarras}"),
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Enviando codigo...'))),

                          },
                          
                        }
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
