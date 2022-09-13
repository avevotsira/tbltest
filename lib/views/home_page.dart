import 'package:flutter/material.dart';
import 'package:tbltest/views/detail_page.dart';
import 'package:tbltest/views/insert_page.dart';
import '../services/remote_service.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student>? products;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    // fetch data from API
    getData();
  }

  getData() async{
    products = await RemoteService().getProducts();
    if(products != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator()
        ),
        child: ListView.builder(

          itemCount: products?.length,
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) =>
                      DetailPage(
                        id: products![index].id.toString(),
                        name: products![index].name,
                        duration: products![index].duration,
                        type: products![index].type)
                    )
                  );
                },
                child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products![index].id.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              products![index].name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InsertPage(),
            ),
          ).then((value) => setState(() {}));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

