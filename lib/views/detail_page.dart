import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/remote_service.dart';
import 'edit_page.dart';
import 'home_page.dart';
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key,this.id="",this.name="",this.duration="",this.type=""}) : super(key: key);
  final String id;
  final String name;
  final String duration;
  final String type;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Student? product;
  //print(product?.name);
  @override
  void initState(){
    super.initState();
    // fetch data from API
    getData(this.widget.id);
  }
  refresh() {
    setState(() {
      //all the reload processes
    });
  }
  getData(id) async {
    product = await RemoteService.getProductByID(id);
    print(product);
    if(product != null){
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Option Test'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            //Navigator.of(context).pop();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())).then((value) => setState(() {}));
          },
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                "ID: ${widget.id}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())).then((value) => setState(() {}));
                },
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) =>
                      EditPage(
                          id: widget.id,
                          name: widget.name,
                          duration: widget.duration,
                          type: widget.type)
                  )
                  );
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),

              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  RemoteService.deleteProduct(widget.id).then((success) {
                    if (success) {
                      showDialog(
                        builder: (context) => AlertDialog(
                          title: Text('Data deleted!!!'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())).then((value) => setState(() {}));
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
                          title: Text('Error deleting!!!'),
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
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
