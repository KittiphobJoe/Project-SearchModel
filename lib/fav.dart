import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // รายการผักที่ผู้ใช้ถูกใจ
  List<Map<String, String>> favoriteVegetables = [
    {
      'name': 'Basil',
      'image': 'assets/basil.jpg', // แทนที่ด้วยเส้นทางของรูปภาพของคุณ
    },
    {
      'name': 'Mint',
      'image': 'assets/mint.jpg', // แทนที่ด้วยเส้นทางของรูปภาพของคุณ
    },
    {
      'name': 'Red Leaf',
      'image': 'assets/red_leaf.jpg', // แทนที่ด้วยเส้นทางของรูปภาพของคุณ
    },
  ];

  // สถานะการแก้ไข
  bool isEditMode = false;

  // ฟังก์ชันลบรายการออกจากลิสต์
  void removeItem(int index) {
    setState(() {
      favoriteVegetables.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB0C4A4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // ย้อนกลับไปหน้าก่อนหน้า
          },
        ),
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.check : Icons.edit, color: Colors.black),
            onPressed: () {
              setState(() {
                isEditMode = !isEditMode; // สลับโหมดแก้ไข
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favoriteVegetables.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    favoriteVegetables[index]['image']!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  favoriteVegetables[index]['name']!,
                  style: TextStyle(fontSize: 18),
                ),
                trailing: isEditMode
                    ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removeItem(index); // ลบรายการ
                        },
                      )
                    : null,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFB0C4A4),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1, // หน้าปัจจุบันคือ Favorite
        selectedItemColor: Colors.black,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/main'); // ลิงค์ไปหน้า main.dart
          }
          // คุณสามารถเพิ่มการจัดการสำหรับการ tab อื่นๆ ได้ที่นี่
        },
      ),
    );
  }
}
