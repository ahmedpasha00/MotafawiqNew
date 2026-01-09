import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../presentation/upload_screen.dart';

class CloudinaryRepository {
  final Dio dio = Dio();

  Future<String?> uploadFile(
      FilePickerResult result, {
        required UploadType type,
        required Function(double) onProgress,
      }) async {
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

    // 👇 نحدد نوع الرفع
    final resourceType = type == UploadType.video ? 'video' : 'image';

    final file = result.files.single;

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path!,
        filename: file.name,
      ),
      'upload_preset': 'motafawik',

      // 👇 تحسينات للفيديو
      if (type == UploadType.video) ...{
        'quality': 'auto',
        'fetch_format': 'auto',
      },
    });

    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload',
      data: formData,
      onSendProgress: (sent, total) {
        if (total > 0) {
          onProgress(sent / total);
        }
      },
    );

    return response.data['secure_url'];
  }
}
