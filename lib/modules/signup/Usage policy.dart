import 'package:beezar/components/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants.dart';

class UsagePolicy extends StatefulWidget {
  UsagePolicy({super.key});

  @override
  State<UsagePolicy> createState() => _UsagePolicyState();
}

class _UsagePolicyState extends State<UsagePolicy> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Padding(
              padding: EdgeInsets.only(right: 1.0),
              child: Text(
                'سياسة الاستخدام',
                style: TextStyle(fontFamily: "ca1", fontSize: 25),
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("سياسة استخدام التطبيق لبيع المستعمل",
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    Text(
                        "مرحبًا بك في تطبيق بيزار . تم تطوير هذه السياسة لضمان تجربة استخدام آمنة وموثوقة لجميع مستخدمي التطبيق، يُرجى قراءة هذه السياسة بعناية قبل استخدام التطبيق.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('المحتوى المعروض',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "نحن نقدم منصة لبيع وشراء المستعمل من منازل وسيارات وعقارات. يجب أن يكون المحتوى المعروض دقيقًا وصادقًا. يُحظر بشكل صارم عرض أو بيع محتوى مخالف للقوانين أو غير أخلاقي، والتلاعب بالمعلومات أو التضليل.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('حماية بياناتك الشخصية',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "يحق لنا استخدام البيانات الشخصية المسموح بها للاغراض التسويقية والدعائية فقط كما نشجع على إجراء المعاملات في أماكن آمنة وبمشاركة شخصية. يُنصح بعدم مشاركة معلومات حساسة، مثل معلومات الدفع الأليكتروني عبر المحادثات داخل التطبيق.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('التصوير والوصف',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "عند عرض منتج للبيع، يجب أن يكون التصوير والوصف دقيقين وممثلين لحالة المنتج. يُمنع استخدام صور مضللة أو وصف غير دقيق.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('حقوق الملكية الفكرية',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "نحن نحترم حقوق الملكية الفكرية للآخرين. يجب على المستخدمين عدم عرض أو بيع محتوى ينتهك حقوق الملكية الفكرية، مثل الصور أو الوصف المنسوخ من مصادر أخرى.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('الالتزام بالقوانين',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "يجب على جميع المستخدمين الالتزام بالقوانين واللوائح المحلية والدولية المعمول بها أثناء استخدام التطبيق. حيث يمنع منعاً باتا ً الاعلان عن بيع الاسلحة والمخدرات والادوية وسيواجه من يقوم بذلك المسائلة القانونية حيث نحتفظ بالحق في اتخاذ إجراءات إذا انتهك أي مستخدم هذه السياسة أو القوانين المعمول بها",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('المسؤولية',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "نحن غير مسؤولين عن أي تعامل يتم بين المستخدمين من خلال التطبيق. يتحمل كل مستخدم مسؤولية معاملاته وتصرفاته داخل التطبيق.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: [
                        Text('* ',
                            style: TextStyle(
                              fontFamily: "ca1",
                              fontSize: 20,
                            )),
                        Text('التغييرات في السياسة',
                            style: TextStyle(
                                fontFamily: "ca1",
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text(
                        "نحتفظ بالحق في تعديل هذه السياسة من وقت لآخر. سيتم إشعار المستخدمين بأي تغييرات بارزة في السياسة.",
                        style: TextStyle(
                            fontFamily: "ca1", fontSize: 15, color: textColor)),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: isChecked,
                          onChanged: (newBool) {
                            setState(() {
                              isChecked = newBool!;
                            });
                          },
                        ),
                        Text(
                          'موافق على سياسة الاستخدام',
                          style: TextStyle(fontSize: 16.0, fontFamily: "ca1"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    CustomBtn(
                        onTapBtn: (){
                          if (isChecked) {
                            Get.toNamed('/choose');
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('يجب الموافقة على سياسة الاستخدام',),
                                  content: Text('لإكمال التسجيل يجب الموافقة على سياسة الاستخدام'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        btnText: 'إستمرار',
                        btnBgColor: mainColor,
                        btnTxtColor: Colors.white)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
