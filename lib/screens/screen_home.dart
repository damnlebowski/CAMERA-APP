

import 'package:camera_app/screens/screen_gallery.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

XFile? image;
String? imagepath;
ValueNotifier<List> galleryNotifier = ValueNotifier([]);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getAllImages();
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Camera'))),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('                  '),
            FloatingActionButton(
              onPressed: () => getImage(source: ImageSource.camera),
              child: const Icon(Icons.camera_alt_outlined),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const Gallery();
                  },
                ));
              },
              child: const Icon(Icons.image),
            ),
          ],
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagepath = (image!.path);
        add(image: image);
      });
    } else {
      return null;
    }
  }
}

add({required image}) async {
  final imageDB = await Hive.openBox('image');
  imageDB.add(imagepath);
  getAllImages();
}

getAllImages() async {
  galleryNotifier.value.clear();
  final imageDB = await Hive.openBox('image');
  galleryNotifier.value.addAll(imageDB.values);
  ValueNotifier(galleryNotifier);
}
