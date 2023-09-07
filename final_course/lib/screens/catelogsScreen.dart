import 'package:final_course/constants/api.dart';
import 'package:final_course/screens/bookingScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CatalogsScreen extends StatefulWidget {
  @override
  _CatalogsScreenState createState() => _CatalogsScreenState();
}

class _CatalogsScreenState extends State<CatalogsScreen> {
  List<Map<String, dynamic>> cars = [];
  int? selectedCarID;
  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/get_car.php'),
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> parsedData =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        cars = parsedData;
      });
    } else {
      throw Exception('Failed to load cars');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Catalogs'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(cars[index]['cImage']),
            title: Text(cars[index]['cName']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Brand: ${cars[index]['cBrand']}'),
                Text('Type: ${cars[index]['cType']}'),
                Text('Passengers: ${cars[index]['cPassengers']}'),
              ],
            ),
            trailing: Text('Price: ${cars[index]['cPrice']}'),
            onTap: () {
              setState(() {
                selectedCarID = int.tryParse(cars[index]['cID']);
// กำหนดค่า selectedCarID
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingScreen(selectedCarID)),
              );
            },
          );
        },
      ),
    );
  }
}
