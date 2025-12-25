import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';

class RowText extends StatefulWidget {
  final String Text;
  final String Text1;
  const RowText({super.key, required this.Text, required this.Text1});

  @override
  State<RowText> createState() => _RowTextState();
}

class _RowTextState extends State<RowText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,

          child: Text( widget.Text ,style: AppTextStyle.Bold20Whit,
          overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        Expanded(
          flex: 0,

          child: Text( widget.Text1 ,style: AppTextStyle.Bold20Whit,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,),
        ),
      ],
    );
  }
}
