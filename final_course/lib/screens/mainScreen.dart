import 'package:final_course/screens/bookingScreen.dart'; // Import หน้า BookingScreen ที่สร้างไว้แล้ว
import 'package:final_course/screens/catelogsScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Booking App'), // แก้ชื่อแอพตามต้องการ
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ยินดีต้อนรับสู่แอพพลิเคชันจองรถ',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogsScreen()),
                );
              },
              child: Text('ดูรายละเอียดรถ'),
            ),
          ],
        ),
      ),
    );
  }
}
