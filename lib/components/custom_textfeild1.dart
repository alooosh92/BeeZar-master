import 'package:beezar/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFields extends StatefulWidget {
  
  TextEditingController textFieldController = TextEditingController();
  dynamic prefix;
  dynamic suffix;
  String myInput ;
  bool IsObsecure;
  var onchange;


  FormFields(this.myInput, this.prefix, this.suffix, this.IsObsecure,
      this.textFieldController,this.onchange);

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  dynamic function;

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child:Container(
      height: 50,
      width: double.infinity,
      child: TextFormField(
          validator: (String? text) {
            if (widget.textFieldController.text == '') {
              return 'هذا الحقل مطلوب !!';
            }
            return null;
          },
          onChanged: widget.onchange,
          obscureText: widget.IsObsecure,
          cursorColor:mainColor,
          controller: widget.textFieldController,
          decoration: InputDecoration(
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            filled: true,
            fillColor: Colors.white,
            floatingLabelStyle:
             TextStyle(color: textColor,fontFamily: "ca1"),
            labelStyle: TextStyle(color: Colors.black,fontFamily: 'ca1'),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: mainColor,
              ),
            ),
            labelText: widget.myInput,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          )),
    )
    );
  }
}