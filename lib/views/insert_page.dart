import 'package:flutter/material.dart';
import '../services/remote_service.dart';
import 'home_page.dart';
class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final _productNameCtrl = TextEditingController();
  final _productPriceCtrl = TextEditingController();
  final _productPhotoCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('New product'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          //onPressed: () => Navigator.of(context).pop(),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())).then((value) => setState(() {}));
          },
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _productNameCtrl,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: _productPriceCtrl,
                decoration: InputDecoration(hintText: 'Duration'),
              ),
              TextField(
                controller: _productPhotoCtrl,
                decoration: InputDecoration(hintText: 'Type'),
              ),
              RaisedButton(
                child:const Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final body = {
                    "name": _productNameCtrl.text.toString(),
                    "duration": _productPriceCtrl.text.toString(),
                    "type":  _productPhotoCtrl.text.toString(),
                  };
                  RemoteService.addProduct(body).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Data added!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _productNameCtrl.text = '';
                                _productPriceCtrl.text = '';
                                _productPhotoCtrl.text = '';
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }else{
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Error Adding!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                        context: context,
                      );
                      return;
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
