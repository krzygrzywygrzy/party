import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      List<String> filePaths = [];
      for (var file in files) {
        String filePath = "/${uid}_${file.path.split("/").last}";
        await firebase_storage.FirebaseStorage.instance
            .ref(filePath)
            .putFile(file);
        filePaths.add(filePath);
      }
      return Right(filePaths);
    } on firebase_storage.FirebaseException {
      return Left(ImageUploadFailure());
    } catch (_) {
      return Left(UnknownFailure());
    }
  }
}
