import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HttpApi());
  }
}

class HttpApi extends StatefulWidget {
  @override
  State<HttpApi> createState() => _HttpApiState();
}

class _HttpApiState extends State<HttpApi> {
  List data = [];
  bool isLoading = true;

  Future ambilData() async {
    var res = await http.get(Uri.parse('https://dummyjson.com/products'));
    var hasil = jsonDecode(res.body);

    setState(() {
      data = hasil['products'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Container(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 18, color: Colors.grey),
              SizedBox(width: 6),
              Text(
                "ketik sesuatu untuk mencari",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          Icon(Icons.camera_alt),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart),
          SizedBox(width: 10),
          Icon(Icons.chat),
          SizedBox(width: 10),
        ],
      ),

      body: ListView(
        children: [
          for (int i = 0; i < 10; i += 2)
            Row(
              children: [
                
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                data[i]['images'][0],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // DISKON
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                color: Colors.orange,
                                child: Text(
                                  "-${data[i]['discountPercentage'].toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),

                            // LABEL
                            Positioned(
                              left: 0,
                              top: 5,
                              child: Container(
                                color: Colors.black54,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Text(
                                  "Star",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i]['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),

                              SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "${data[i]['rating']}",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),

                              Text(
                                "Rp ${data[i]['price']}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "${data[i]['stock']} terjual",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ===== KANAN =====
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                data[i + 1]['images'][0],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                color: Colors.orange,
                                child: Text(
                                  "-${data[i + 1]['discountPercentage'].toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              left: 0,
                              top: 5,
                              child: Container(
                                color: Colors.black54,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Text(
                                  "Star",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i + 1]['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),

                              SizedBox(height: 4),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "${data[i + 1]['rating']}",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4),

                              Text(
                                "Rp ${data[i + 1]['price']}",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "${data[i + 1]['stock']} terjual",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

