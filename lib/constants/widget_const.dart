import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api_clone/constants/text_style.dart';

class HeadingRow {
  static Widget row({required String heading, required TextStyle style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: style,
        ),
        InkWell(
          onTap: (){

          },
          child: Text(
            "See all",
            style: mTextStyle.mStyle(
              fontSize: 15,
              fontColor: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
