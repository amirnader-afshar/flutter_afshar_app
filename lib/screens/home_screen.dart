import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_afshar_app/Model/Product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class homepage extends StatelessWidget {
  List<Product> products = [];
  void getNewProduct(){
    var url="http://192.168.1.7:3000/api/product";
    Map <String,String> userHeader = {"Content-type": "application/json", "x-auth": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjIzMmQ1YzE5MGMwNTE4MGMyMjAyYzIiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTk2MTQxMjQyfQ.VReowAw_d4wawd12_HadyAI8nAC0ZsqBSGYsIYFutW8"};
    http.get(url,headers:userHeader ).then((response)  {
      print (response.statusCode);
      if (response.statusCode==200){
        List jsonResponse=convert.jsonDecode(response.body);
        for (int i=0;i<jsonResponse.length;i++){
          products.add(new Product(title: jsonResponse[i]['name'],
          price: jsonResponse[i]['price']
              ,img_url: jsonResponse[i]['img_url']));
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
//    products.add(new Product(
//        title: "همبرگر", img_url: "images/Hamburger.jpg", price: 25000));
//    products.add(new Product(
//        title: "هات داگ", img_url: "images/hotdog.jpg", price: 21000));
//    products.add(
//        new Product(title: "پاستا", img_url: "images/pasta.jpg", price: 42000));
  getNewProduct();
    return Container(
      height: 270,
      child: ListView.builder(
        itemBuilder: listRow,
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget listRow(BuildContext context, int index) {
    return Container(
      width: 210,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white70),
      child: Column(
        children: <Widget>[
          Container(

            child: Image.asset(
              products[index].img_url,
              width: 200,
              height: 200,
            ),
          ),
          Text(products[index].title),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              products[index].price.toString(),
              textAlign: TextAlign.left,
            ),
            width: 210,
          )
        ],
      ),
    );
  }
}
