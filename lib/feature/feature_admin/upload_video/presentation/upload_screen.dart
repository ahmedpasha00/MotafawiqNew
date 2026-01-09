import 'dart:io';
import 'package:al_motafawiq/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../core/wigets/video_player_widget.dart';
import '../data/models/map_video_data.dart';
import '../data/models/video_model.dart';
import '../data/repo/cloudinary_repository.dart';
import '../data/repo/videos_repository.dart';
import '../../../../core/widgets/cousstom_botton.dart';
import '../../../../core/widgets/cousttom_text_feld.dart';
import '../../core/wigets/cousstom_upload_videos.dart';

/// نوع الملف
enum UploadType { video, image }

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  // Controllers
  final videoTitleController = TextEditingController();
  final gradeController = TextEditingController();
  final unitController = TextEditingController();
  final durationController = TextEditingController();

  // File
  FilePickerResult? selectedFile;
  File? file;
  UploadType? uploadType;

  // State
  bool isUploading = false;
  bool showSuccess = false;
  double uploadProgress = 0.0;
  bool isLoadingFile = false; // للتحكم باللوتي أثناء اختيار الملف

  late CloudinaryRepository repository;
  late VideosRepository videosRepository;

  @override
  void initState() {
    super.initState();
    repository = CloudinaryRepository();
    videosRepository = VideosRepository();
  }

  @override
  void dispose() {
    videoTitleController.dispose();
    gradeController.dispose();
    unitController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  /// ================== PREVIEW ==================
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                    child: SizedBox(
                      height: 300.h,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: showSuccess
                            ? _successView()
                            : file != null
                            ? _filePreview()
                            : _emptyView(),
                      ),
                    ),
                  ),

                  if (!showSuccess) ...[
                    SizedBox(height: 20.h),

                    /// ================== PICK FILE ==================
                    CousstomUploadVideos(
                      tittel: "اختر فيديو أو صورة",
                      onTap: pickFile,
                      child: const SizedBox.shrink(),
                    ),

                    SizedBox(height: 12.h),

                    CousstomBotton(
                      titell: "🗑 حذف الملف",
                      onTap: resetAll,
                    ),

                    SizedBox(height: 20.h),
                    if (file != null && !showSuccess)
                      Card(

                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(16.r),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Container(
                               width: double.infinity, // هنا خليته بعرض الشاشة

                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15.r),
                                 color: AppColors.primaryColor,
                               ),
                               child: Column(
                                 children: [
                                   Text("📌 العنوان : ${videoData['title']}"),
                                   Text("🎓 الصف : ${videoData['grade']}"),
                                   Text("📘 الوحدة : ${videoData['unit']}"),
                                   Text("⏱️ المدة : ${videoData['duration']}"),
                                 ],
                               ),
                             )
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 16.h),

                    /// ================== INPUTS ==================
                    CousttomTextFeld(
                      controller: videoTitleController,
                      hintText: "عنوان",
                      onChanged: (v) => videoData["title"] = v,
                    ),
                    SizedBox(height: 10.h),
                    CousttomTextFeld(
                      controller: gradeController,
                      hintText: "الصف",
                      onChanged: (v) => videoData["grade"] = v,
                    ),
                    SizedBox(height: 10.h),
                    CousttomTextFeld(
                      controller: unitController,
                      hintText: "الوحدة",
                      onChanged: (v) => videoData["unit"] = v,
                    ),
                    SizedBox(height: 10.h),
                    CousttomTextFeld(
                      controller: durationController,
                      hintText: "المدة",
                      onChanged: (v) => videoData["duration"] = v,
                    ),

                    SizedBox(height: 20.h),

                    /// ================== PROGRESS ==================
                    if (isUploading)
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: uploadProgress,
                            minHeight: 10.h,
                            backgroundColor: Colors.grey.shade300,
                            color: Colors.pink,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "جاري الرفع ${(uploadProgress * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    SizedBox(height: 20.h),

                    /// ================== UPLOAD ==================
                    CousstomBotton(
                      titell: isUploading ? "جاري الرفع..." : "🚀 رفع",
                      onTap: isUploading ? null : upload,
                    ),
                    SizedBox(height: 15.h,),
                    CousstomBotton(titell: "رجوع",
                    onTap: (){

                      Navigator.pop(context);
                    },
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================== WIDGETS ==================
  Widget _emptyView() => const Center(
    child: Text(
      "لا يوجد ملف مختار",
      style: TextStyle(fontSize: 22, color: Colors.pink),
    ),
  );

  Widget _successView() => Container(

    width: double.infinity,
    decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(15.r),
  ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.check_circle, color: Colors.green, size: 60),
        SizedBox(height: 10),
        Text("تم الرفع بنجاح",
            style: TextStyle(fontSize: 20, color: Colors.green)),
      ],
    ),
  );

  Widget _filePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        uploadType == UploadType.video
            ? VideoPlayerWidget(file: file!)
            : Image.file(file!, fit: BoxFit.cover),
        if (isLoadingFile)
          Container(
            color: Colors.black45,
            child: Center(
              child: Lottie.asset(
                'assets/lottie/search.json',
                width: 100.w,
                height: 100.w,
                repeat: true,
              ),
            ),
          ),
      ],
    );
  }

  /// ================== LOGIC ==================
  Future<void> pickFile() async {
    setState(() => isLoadingFile = true);

    selectedFile = await FilePicker.platform.pickFiles(type: FileType.media);

    if (selectedFile != null && selectedFile!.files.isNotEmpty) {
      final picked = selectedFile!.files.single;
      file = File(picked.path!);

      final ext = picked.extension?.toLowerCase();
      uploadType =
      (ext == 'mp4' || ext == 'mov') ? UploadType.video : UploadType.image;
    }

    setState(() => isLoadingFile = false);
  }

  Future<void> upload() async {
    if (file == null || uploadType == null) return;

    if (videoData.values.any((v) => v.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("اكمل كل البيانات")),
      );
      return;
    }

    setState(() {
      isUploading = true;
      uploadProgress = 0;
    });

    final url = await repository.uploadFile(
      selectedFile!,
      type: uploadType!,
      onProgress: (p) => setState(() => uploadProgress = p),
    );

    if (url == null) return;

    final model = VideoModel(
      title: videoData["title"]!,
      grade: videoData["grade"]!,
      unit: videoData["unit"]!,
      duration: videoData["duration"]!,
      videoUrl: url,
      isVideo: uploadType == UploadType.video,
    );

    await videosRepository.addVideo(model);

    setState(() {
      isUploading = false;
      showSuccess = true;
    });

    Future.delayed(const Duration(seconds: 5), resetAll);
  }

  void resetAll() {
    setState(() {
      file = null;
      selectedFile = null;
      uploadType = null;
      uploadProgress = 0;
      isUploading = false;
      showSuccess = false;
      isLoadingFile = false;
      videoData.updateAll((k, v) => "");
      videoTitleController.clear();
      gradeController.clear();
      unitController.clear();
      durationController.clear();
    });
  }
}
