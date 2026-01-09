

import 'package:al_motafawiq/feature/feature_admin/upload_video/data/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideosRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addVideo (VideoModel video )async{
    await firestore.collection("videos").add(video.toMap());
  }
  }