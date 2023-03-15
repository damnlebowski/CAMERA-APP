import 'dart:io';
import 'package:camera_app/screens/screen_home.dart';
import 'package:camera_app/screens/screen_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: galleryNotifier,
          builder: (context, value, child) => GridView.builder(
            itemCount: galleryNotifier.value.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ViewImage(
                        imgIndex: index,
                      );
                    },
                  ));
                },
                child: Container(
                  color: Colors.blue,
                  child: Image.file(
                    File(value[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

add() async {
  final imageDB = await Hive.openBox('image');
  imageDB.add(imagepath);
  await getAllImages();
}

delete(int index) async {
  final imageDB = await Hive.openBox('image');
  imageDB.deleteAt(index);
  await getAllImages();
}

getAllImages() async {
  final imageDB = await Hive.openBox('image');
  galleryNotifier.value.clear();
  galleryNotifier.value.addAll(imageDB.values);
  galleryNotifier.notifyListeners();
}
