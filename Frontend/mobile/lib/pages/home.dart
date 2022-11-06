import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/components/appbar.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/services/network.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> codes = <Item>[];
  Networking net = Networking("https://ebb2-128-235-250-65.ngrok.io", "5000");
  int caseNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(),
      body: Builder(
        builder: (context) {
          switch (caseNumber) {
            case 1: //Cart
              return (Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: codes.length,
                      itemBuilder: (context, int index) {
                        return (ListTile(
                          title: Text(codes[index].name),
                          subtitle: Text(codes[index].rating.toString()),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              codes.removeAt(index);
                              setState(() {});
                            },
                          ),
                        ));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            final snackBar =
                                SnackBar(content: const Text("Emptied Cart"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            codes = <Item>[];
                            setState(() {});
                          },
                          child: Text("Empty Cart")),
                      ElevatedButton(onPressed: () {}, child: Text("Checkout"))
                    ],
                  )
                ],
              ));
            case 2: //Profile
              return (Consumer<Authentication>(
                builder: (context, authProvider, child) {
                  return (Column(
                    children: [
                      TextButton(
                          child: Text("Logout"),
                          onPressed: () => authProvider.signOut())
                    ],
                  ));
                },
              ));
            default: //Home
              double ratingSum = 0;
              double ratingAverage = 0;
              if (codes.length > 0) {
                codes.forEach((e) {
                  ratingSum += e.rating;
                });
                ratingAverage = (ratingSum / codes.length);
              }

              int red = ((ratingAverage / 10) * 255).toInt();
              int green = (255 - (ratingAverage / 10) * 255).toInt();

              return Center(
                child: (SizedBox(
                  width: 150,
                  height: 150,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(red, green, 0, 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Score",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(ratingAverage.toString())
                      ],
                    ),
                  ),
                )),
              );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => {caseNumber = 0, setState(() {})},
              ),
              IconButton(
                  icon: Icon(Icons.qr_code_scanner_outlined),
                  onPressed: () => getScannedItem(codes)),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => {caseNumber = 1, setState(() {})},
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () => {caseNumber = 2, setState(() {})},
              ),
            ],
          ),
        ),
      ),
    );
  }

  getScannedItem(codes) async {
    print("scanning barcode");
    int ean = int.parse(await FlutterBarcodeScanner.scanBarcode(
        'green', "Cancel Scan", false, ScanMode.BARCODE));
    print(ean);
    http.Response result = await net.sendPost("eanlookup", {"ean": ean});
    print(result.body);
    Map<String, dynamic> data = json.decode(result.body);
    Item temp = Item(data['name'], data['score']);
    codes.add(temp);
    print(data['name']);
    setState(() {});
  }
}

class Item {
  late String name;
  late double rating;

  Item(n, r) {
    name = n;
    rating = r;
  }
}
