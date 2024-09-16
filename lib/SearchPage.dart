import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหา'),
        backgroundColor: Color(0xFFA4C49A), // สีเขียวในแถบด้านบน
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'ค้นหาพืช',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ฟังก์ชันค้นหาเมื่อกดปุ่ม
              },
              child: Text('ค้นหา'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                  onPressed: () async {
                    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      // ทำสิ่งที่ต้องการหลังจากเลือกภาพจากกล้อง
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ถ่ายภาพสำเร็จ: ${photo.name}')),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.image, color: Colors.black, size: 30),
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // ทำสิ่งที่ต้องการหลังจากเลือกภาพจากแกลลอรี่
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('เลือกรูปภาพสำเร็จ: ${image.name}')),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
