import 'package:flutter/material.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DBStudentQrCode extends StatefulWidget {
  const DBStudentQrCode() : super();

  @override
  State<DBStudentQrCode> createState() => _DBStudentQrCodeState();
}

class _DBStudentQrCodeState extends State<DBStudentQrCode> {
  String student_id ="";


  @override
  Widget build(BuildContext context) {
    Utils.getIntValue("studentId").then((value) => {
    setState(() {
    student_id = value.toString();
    })

    });
    return Scaffold(
      body: Container(
        child: student_id.isNotEmpty?Center(
          child: QrImage(
            data:student_id ,
            size: 300,
            gapless: false,
          ),
        ):Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
