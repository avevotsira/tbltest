import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;
class RemoteService{
  Future<List<Student>?> getProducts() async{
    var client = http.Client();
    var uri = Uri.parse('http://192.168.43.15:3002/student');
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return studentsFromJson(json);
    }
  }

  static Future<Student?> getProductByID(id) async{
    var client = http.Client();
    var uri = Uri.parse('http://192.168.43.15:3002/student/${id}');
    print(uri);
    var response = await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;

      return studentFromJson(json);
    }
  else { var json = response.body;
      return studentFromJson(json);
    }
  }

  static Future<bool> addProduct(body) async {
    var jsonb = json.encode(body);
    //if not working use "Content-Type": "application/json"
    final response = await http.post(Uri.parse('http://192.168.43.15:3002/createstudent')
        ,headers: {"Content-Type": "application/json"}
        ,body: jsonb);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> deleteProduct(id) async {
    final body = {
      'id': id.toString(),
    };
    final response = await http.post(Uri.parse('http://192.168.43.15:3002/delete/$id'),body:body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool?> updateProduct(body) async {
    print(body);
    var jsonb = json.encode(body);
    final upid = body['id'];
    print(upid);
    final response = await http.post(Uri.parse('http://192.168.43.15:3002/update/$upid'),
        headers: {"Content-Type": "application/json"}, body: jsonb);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return true;
    }
  }
}