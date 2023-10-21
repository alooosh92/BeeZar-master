import 'package:beezar/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تواصل معنا"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/co-logo.png',
                width: 300,
              ),
              Text(
                'تواصل معنا',
                style: TextStyle(
                    fontFamily: 'ca1',
                    fontSize: 30,
                    color: mainColor,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'نحن نعمل باستمرار لجعل تجربتك مع بيزار أسهل',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ca1',
                    color: textColor,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                ' سنقوم بالرد على رسالتكم خلال 24 ساعة',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ca1',
                    color: textColor,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'رقم الجوال 00905347784520',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ca1',
                    color: textColor,
                    fontWeight: FontWeight.w900),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الايميل',
                    style: TextStyle(
                        fontFamily: 'ca1',
                        fontSize: 17,
                        color: textColor,
                        fontWeight: FontWeight.w900),
                  ),
                  TextButton(
                    onPressed: () {
                      _launchURL(
                          'mailto:abdulelah@arg-tr.com'); // Replace with your email
                    },
                    child: Text(
                      'abdulelah@arg-tr.com',
                      style: TextStyle(
                          fontSize: 17,
                          color: textColor,
                          fontWeight: FontWeight
                              .w900 // Change the text color to indicate it's a link.
                          ),
                    ),
                  ),
                ],
              ),
              Text(
                'قم بزيارة موقعنا الأليكتروني',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'ca1',
                    color: textColor,
                    fontWeight: FontWeight.w900),
              ),
              TextButton(
                onPressed: () {
                  _launchURL(
                      'https://arg-tr.com/'); // Replace with your website URL
                },
                child: Text(
                  'www.arg-tr.com',
                  style: TextStyle(
                      fontSize: 17,
                      color: textColor,
                      fontWeight: FontWeight
                          .w900 // Change the text color to indicate it's a link.
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.03,
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff1a6ed8),
                      border: Border()),
                  child: MaterialButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.facebook.com/profile.php?id=100095002767101&mibextid=ZbWKwL');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "تابع صفحتنا على فيسبوك",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ca1'),
                        ),
                        Icon(
                          FontAwesomeIcons.facebook,
                          size: 30,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.03,
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff1a6ed8),
                      border: Border()),
                  child: MaterialButton(
                    onPressed: () {
                      _launchURL(
                          'https://www.linkedin.com/company/96034466/admin/feed/posts/');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'تابع صفحتنا على لينكدإن',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ca1'),
                        ),
                        Icon(
                          FontAwesomeIcons.linkedin,
                          size: 30,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactUsScreen(),
  ));
}
