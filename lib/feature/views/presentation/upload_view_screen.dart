//
//
// import 'package:al_motafawiq/feature/feature_admin/upload_video/service/cloudinary_service.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class UploadViewScreen extends StatefulWidget {
//   const UploadViewScreen({super.key});
//
//   @override
//   State<UploadViewScreen> createState() => _UploadViewScreenState();
// }
//
// class _UploadViewScreenState extends State<UploadViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     final selectedFile = ModalRoute.of(context)!.settings.arguments as FilePickerResult;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0.r),
//         child: Column(
//           children: [
//             TextFormField(
//               readOnly: true,
//               initialValue: selectedFile.files.first.name,
//               decoration: InputDecoration(label: Text("Name")),
//             ),
//             TextFormField(
//               readOnly: true,
//               initialValue: selectedFile.files.first.extension,
//               decoration: InputDecoration(label: Text("Extension")),
//             ),
//             TextFormField(
//               readOnly: true,
//               initialValue: "${selectedFile.files.first.size} bytes. ",
//               decoration: InputDecoration(label: Text("Size")),
//             ),
// SizedBox(height: 30.h,),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: OutlinedButton(onPressed: (){
//                     Navigator.pop(context);
//                   }, child: Text("Cancel")),
//                 ),
//                 SizedBox(width: 30.w,),
//                 Expanded(child: ElevatedButton(onPressed: () async {
//                   final result = await uploadToCloundinary(selectedFile);
//
//                   if(result){
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text("File Upload Sucsses"),
//
//
//                     ));
//                     Navigator.pop(context);
//                   }
//                   else{
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text("Upload Cannod File"),
//                     ));
//                   }
//
//                 }, child: Text("Upload")))
//               ],
//             )
//           ],
//         ),
//       )
//
//
//
//
//     );
//   }
// }
