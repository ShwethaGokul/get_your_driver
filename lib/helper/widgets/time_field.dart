import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../textstyle.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.textEditingController,
    this.hint,
  this.isReadOnly = false,
  this.keyBoardType,
  this.onChangeHandler,
  });
  final String? hint;
  final TextEditingController? textEditingController;
  final bool isReadOnly;
  final TextInputType? keyBoardType;
  final Function(dynamic val)? onChangeHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * .3,
      padding: const EdgeInsets.only(left: 20),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: TextField(
  keyboardType: keyBoardType,
        readOnly: isReadOnly,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Tstyles.greycolor16,
          border: InputBorder.none,
        ),
        onChanged: (value) =>
        {if (onChangeHandler != null) onChangeHandler!(value)},
        inputFormatters: [
          LengthLimitingTextInputFormatter(2)
        ],

      ),
    );
  }
}
