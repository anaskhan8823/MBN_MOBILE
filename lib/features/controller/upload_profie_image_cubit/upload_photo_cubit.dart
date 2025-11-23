import 'dart:io';
import 'package:dalil_2020_app/core/helper/app_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'upload_photo_state.dart';

class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  UploadPhotoCubit() : super(UploadPhotoInitial());
  List<File> imagesList = [];
  List<File> imagesListsEdit = [];
  File? profileImage;
  final ImagePicker picker = ImagePicker();

  ///profile functions
  Future<void> changeProfile() async {
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result == null) {
      return;
    }
    profileImage = File(result.path);
    emit(UploadPhotoInitial());
  }

  Future<void> clear() async {
    profileImage = null;
  }

  ///add product functions
  Future<void> pickImagesForAddProduct() async {
    final pickedFiles = await picker.pickMultiImage();
    if (imagesList.length >= 5) {
      return;
    }
    if (pickedFiles.isNotEmpty) {
      final newImages = pickedFiles.map((file) => File(file.path)).toList();
      final remainingSlots = 5 - imagesList.length;
      imagesList.addAll(newImages.take(remainingSlots));
      emit(UploadPhotoUpdated());
    }
  }

  void removeImageForAddProduct(int index) {
    imagesList.removeAt(index);
    emit(UploadPhotoInitial());
  }

  ///edit product functions
  void setInitialImages(List<File> imagePaths) {
    imagesListsEdit = imagePaths;
    emit(UploadPhotoInitial());
  }

  Future<void> pickImagesEdit() async {
    try {
      emit(UploadPhotoLoading());
      final newImages = await picker.pickMultiImage();
      final images = newImages.map((file) => File(file.path)).toList();
      if (images.isNotEmpty) {
        final int availableSlots = 5 - imagesListsEdit.length;
        imagesListsEdit.addAll(images.take(availableSlots));
        emit(UploadPhotoInitial());
      } else {
        emit(UploadPhotoInitial());
      }
    } catch (e) {
      AppToast.error(e.toString());
      emit(UploadPhotoInitial());
    }
  }

  void updateImage(int index, dynamic file) {
    if (file is String || file is File) {
      imagesListsEdit[index] = file;
    }
    emit(UploadPhotoInitial());
  }

  Future<void> pickImage(index) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      final newImage = File(result.path);
      updateImage(index, newImage);
      emit(UploadPhotoInitial());
    }
  }

  void removeImages(int index) {
    if (index >= 0 && index < imagesListsEdit.length) {
      imagesListsEdit.removeAt(index);
      emit(UploadPhotoInitial());
    }
  }
}
