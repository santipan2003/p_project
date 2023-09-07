import 'dart:convert';
import 'package:final_course/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:http/http.dart' as http;// เพิ่ม import สำหรับใช้งานการจัดรูปแบบวันที่

class BookingScreen extends StatefulWidget {
  final int? selectedCarID; // เพิ่มตัวแปร selectedCarID ที่รับค่าผ่าน constructor

  BookingScreen(this.selectedCarID); // constructor
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? uDateFrom;
  DateTime? uDateTo;
  
  // สร้างฟังก์ชันสำหรับการบันทึกข้อมูลการจอง
Future<void> _saveBooking() async {
    if (uDateFrom != null && uDateTo != null && widget.selectedCarID != null) {
      // เตรียมข้อมูลที่จะส่งไปบันทึก
      final Map<String, dynamic> bookingData = {
        'uDateFrom': DateFormat('yyyy-MM-dd').format(uDateFrom!),
        'uDateTo': DateFormat('yyyy-MM-dd').format(uDateTo!),
        'cID': widget.selectedCarID, // ใช้ค่า selectedCarID ที่รับมาจาก constructor
      };

      final response = await http.post(
        Uri.parse('$apiEndpoint/booking.php'), // เปลี่ยน URL ตามที่คุณจัดเก็บไฟล์ booking.php
        body: jsonEncode(bookingData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // ถ้าบันทึกสำเร็จ ให้ทำการกลับไปยังหน้าก่อนหน้า
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาดในการบันทึกข้อมูลการจอง'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณาเลือกวันเวลาเริ่มต้นและสิ้นสุด'),
        ),
      );
    }
  }

// ในส่วนอื่น ๆ ใน StatefulWidget คุณสามารถเรียกใช้ _saveBooking() เมื่อกดปุ่ม "Book Now" ได้

  // Function to show date picker for uDateFrom
  Future<void> _selectUDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != uDateFrom) {
      setState(() {
        uDateFrom = picked;
      });
    }
  }

  // Function to show date picker for uDateTo
  Future<void> _selectUDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != uDateTo) {
      setState(() {
        uDateTo = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Booking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Select Booking Dates:'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectUDateFrom(context);
              },
              child: Text(
                uDateFrom != null
                    ? DateFormat('yyyy-MM-dd').format(uDateFrom!)
                    : 'Select Start Date',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectUDateTo(context);
              },
              child: Text(
                uDateTo != null
                    ? DateFormat('yyyy-MM-dd').format(uDateTo!)
                    : 'Select End Date',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (uDateFrom != null && uDateTo != null) {
                  // เพิ่มโค้ดเพื่อบันทึกข้อมูลการจองลงในฐานข้อมูล
                  // คุณสามารถใช้ค่า uDateFrom และ uDateTo ในการบันทึกข้อมูล

                  // เมื่อบันทึกเสร็จสิ้นแล้ว ให้ทำการกลับไปยังหน้าก่อนหน้า
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('กรุณาเลือกวันเวลาเริ่มต้นและสิ้นสุด'),
                    ),
                  );
                }
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}