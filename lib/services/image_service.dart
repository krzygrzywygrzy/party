import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  List<File> files = [];
  final _picker = ImagePicker();

  Future getImageFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      files.add(File(pickedFile.path));
    }
  }

  Future getImageFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      files.add(File(pickedFile.path));
    }
  }

  Future uploadImages() async {
    throw UnimplementedError();
  }
}
