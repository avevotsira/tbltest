import 'package:flutter/material.dart';
import 'package:tbltest/views/detail_page.dart';
import '../services/remote_service.dart';
import 'home_page.dart';
class EditPage extends StatefulWidget {
  const EditPage({Key? key,this.id="",this.name="",this.duration="",this.type=""}) : super(key: key);
  final String id;
  final String name;
  final String duration;
  final String type;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _productNameCtrl = TextEditingController();
  final _productPriceCtrl = TextEditingController();
  final _productPhotoCtrl = TextEditingController();
  @override
  void initState(){
    super.initState();
    _productNameCtrl.text = this.widget.name;
    _productPriceCtrl.text = this.widget.duration;
    _productPhotoCtrl.text = this.widget.type;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          //onPressed: () => Navigator.of(context).pop(),
          onPressed: (){
            //Navigator.pop(context, true);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) =>
                DetailPage(
                    id: this.widget.id,
                    name: _productNameCtrl.text,
                    duration:_productPriceCtrl.text,
                    type: _productPhotoCtrl.text)
            )
            );
          },
        ),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _productNameCtrl,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(

                controller: _productPriceCtrl,
                decoration: InputDecoration(hintText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _productPhotoCtrl,
                decoration: InputDecoration(hintText: 'Photo'),
              ),
              RaisedButton(
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final body = {
                    "id": this.widget.id,
                    "name": _productNameCtrl.text,
                    "duration": _productPriceCtrl.text,
                    "type": _productPhotoCtrl.text,
                  };
                  RemoteService.updateProduct(body).then((bool) {
                    if (bool!) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Data updated!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                ).then((value) => setState(() {}));
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
                          title: Text('Error updating!!!'),
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
