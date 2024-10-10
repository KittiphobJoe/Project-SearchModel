import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlantScreen(),
    );
  }
}

class PlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB5D5B5),
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D5B5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text('ตะไคร้', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://example.com/placeholder-image.jpg', // Replace with actual image URL
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildInfoButton('ภาษาถิ่น'),
                _buildInfoButton('ข้อมูลทั่วไป'),
                _buildInfoButton('สรรพคุณ'),
                _buildInfoButton('เมนูแนะนำ'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'หน้าหลัก'), // Home tab
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'ชื่นชอบ'), // Favorites tab
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'โปรไฟล์'), // Profile tab
        ],
        
      ),
    );
  }

  Widget _buildInfoButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        child: Text(text, style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}