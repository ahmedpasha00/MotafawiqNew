import 'package:flutter/cupertino.dart';

@immutable
sealed class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadProgress extends UploadState {
  final double progress; // من 0 إلى 1
  UploadProgress(this.progress);
}

class UploadSuccess extends UploadState {
  final String message;
  UploadSuccess(this.message);
}

class UploadErorr extends UploadState {
  final String message;
  UploadErorr(this.message);
}
