import 'dart:io';

import 'package:camera_app/screens/screen_gallery.dart';
import 'package:camera_app/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ViewImage extends StatelessWidget {
  ViewImage({super.key, required this.imgIndex});
  int imgIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          actions: [
            IconButton(
                onPressed: () {
                  delete(imgIndex);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Gallery(),
                  ));
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Center(
          child: Image.file(
            File(galleryNotifier.value[imgIndex]),
          ),
        ));
  }
}

delete(int index) async {
  final imageDB = await Hive.openBox('image');
  imageDB.deleteAt(index);
  await getAllImages();
}
