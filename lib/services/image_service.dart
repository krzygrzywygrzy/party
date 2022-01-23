import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party/core/failure.dart';

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

  Future<Either<Failure, List<String>>> uploadImages() async {
    throw UnimplementedError();
  }
}
