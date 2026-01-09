import 'package:al_motafawiq/feature/feature_admin/upload_video/data/cubit/upload_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/upload_screen.dart';
import '../models/video_model.dart';
import '../repo/cloudinary_repository.dart';
import '../repo/videos_repository.dart';

class UploadCubit extends Cubit<UploadState> {
  final CloudinaryRepository repository;
  final VideosRepository videosRepository;

  UploadCubit(this.repository, this.videosRepository) : super(UploadInitial());

  /// دالة رفع الفيديو أو الصورة
  Future<void> upload({
    required FilePickerResult? file,
    required UploadType type,
    required String title,
    required String grade,
    required String unit,
    required String duration,
  }) async {
    emit(UploadLoading());

    try {
      // رفع الملف
      final response = await repository.uploadFile(
        file!,
        onProgress: (progress) {
          emit(UploadProgress(progress)); // تحديث شريط التقدم
        },
        type: type, // تحديد نوع الملف
      );

      if (response == null) {
        emit(UploadErorr("لم يتم اختيار أي ملف"));
        return;
      }

      // إنشاء موديل الفيديو / الصورة
      final video = VideoModel(
        title: title,
        grade: grade,
        unit: unit,
        duration: duration,
        videoUrl: response,
        isVideo: type == UploadType.video,
      );

      // حفظ في Firebase
      await videosRepository.addVideo(video);

      emit(UploadSuccess("تم الرفع بنجاح"));
    } catch (e) {
      emit(UploadErorr(e.toString()));
    }
  }
}
