import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/features/profile/widgets/phone_field_widget.dart';

import '../../../features/common/block_button_widget.dart';
import '../../../features/common/circular_loading_widget.dart';
import '../../../features/common/text_field_widget.dart';
import '../../../features/common/ui.dart';
import '../../../routes/app_routes.dart';
import '../../../styles/styles.dart';
import '../controller/addtax_controller.dart';
import '../controller/edittax_controller.dart';



class EditTaxView extends GetView<EditTaxController>{

  final arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    controller.loginFormKey = new GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Tax".tr,
            style: Get.textTheme.subtitle1!.merge(TextStyle(fontWeight: FontWeight.w500)),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: Form(
          key: controller.loginFormKey,
          child: ListView(
            primary: true,
            children: [

              Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        labelText: "Tax Name".tr,
                        hintText: "Please Enter Tax Name".tr,
                        // initialValue: (controller.currentUser.value.name)!,
                        // onSaved: (input) => controller.currentUser.value.name = input,
                        validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                        iconData: Icons.note_rounded,
                        isFirst: true,
                        isLast: false,
                      ),
                      TextFieldWidget(
                        labelText: "Tax Rate".tr,
                        hintText: "Please Enter Tax Rate".tr,
                        // initialValue: (controller.currentUser.value.name)!,
                        // onSaved: (input) => controller.currentUser.value.name = input,
                        validator: (input) => input!.length < 0 ? "Value should be  more than or eqauls to 0".tr : null,
                        iconData: Icons.percent,
                        keyboardType: TextInputType.phone,
                        isFirst: false,
                        isLast: false,
                      ),
                      TextFieldWidget(
                        labelText: "Description".tr,
                        hintText: "Please Enter Description".tr,
                        // initialValue: (controller.currentUser.value.name)!,
                        // onSaved: (input) => controller.currentUser.value.name = input,
                        validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                        iconData: Icons.edit,
                        isFirst: false,
                        isLast: true,
                      ),

                    ],
                  );
                }
              }),

              // Row(
              //   // crossAxisAlignment: WrapCrossAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Image.network('https://cdn-icons-png.flaticon.com/512/9720/9720868.png',scale: 24,color: Colors.blue,),
              //     Expanded(
              //         child: Text('The salary is calculated based on daily attendence status Present/Absent.The salary will not be calculated for a week off or holiday.',textDirection: TextDirection.ltr,maxLines: 7,).paddingOnly(left: 5.0)),
              //   ],
              // ).paddingSymmetric(horizontal: 20.0,vertical: 10),

              BlockButtonWidget(
                onPressed: () {
                  if(arg.toString()=="add"){
                    Get.back();

                  }else{
                    Get.offAndToNamed(Routes.ADD_QUOTE);
                  }
                },
                color: Colors.orange,
                text: Text(
                  "Submit".tr,
                  style: Get.textTheme.headline6!.merge(TextStyle(color: Colors.white)),
                ),
              ).paddingOnly(top:15,bottom:25,right: 20,left: 20),
            ],
          ),
        ),

      ),
    );
  }
}

class GetHours extends StatefulWidget {
  const GetHours({Key? key}) : super(key: key);

  @override
  State<GetHours> createState() => _GetHoursState();
}

class _GetHoursState extends State<GetHours> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var jobhour = "Select working time";

    String? valueChoose;
    List listItem = [
      '9 to 6',
      '8 to 5',
      'Custome Time',
    ];

    bool last = false;
    var click = "false";

    String? valueChoose1;
    List listItem1 = [
      'Full-Time',
      'Part-Time',
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            decoration: BoxDecoration(
                color: page,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                ],
                border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Text('Working Time',style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.start,)),
                Row(
                  children: [
                    Icon(Icons.apartment_outlined,color: Colors.grey.shade500,),
                    Expanded(
                      flex: 1,
                      child: DropdownButton(
                          underline: SizedBox(),
                          hint: Text(
                            'Please select working time',
                            style: TextStyle(fontSize: size.width * nine),
                          ),
                          value: valueChoose,
                          icon: Icon(Icons.arrow_drop_down),
                          // iconSize: 36,
                          isExpanded: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * nine,
                              fontWeight: FontWeight.w500
                          ),
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: TextStyle(
                                    fontSize: size.width * ten,
                                    color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (
                              newValue,
                              ) {
                            valueChoose = newValue as String?;

                            setState(() {
                              print(valueChoose);


                            });
                          }).marginOnly(left: 14.0,right: 0.0,top: 0.0,bottom: 0),
                    ),
                  ],
                ),



              ],
            ),
          ),

        ],
      ),
    );
    ;
  }

}

class Drop extends StatefulWidget {
  const Drop({Key? key}) : super(key: key);

  @override
  State<Drop> createState() => _DropState();
}

class _DropState extends State<Drop> {
  String? valueChoose;
  List listItem = [
    '8 to 5',
    '9 to 6',
    '10 to 7 ',
    'Add Work Timing',
  ];
  String? valueChoose1;
  List listItem1 = [
    'Hourly',
    'Daily',
    'Monthly',
  ];

  var process;



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            decoration: BoxDecoration(
                color: page,
                // borderRadius: buildBorderRadius,
                boxShadow: [
                  BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                ],
                border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Working Time',style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.start,),
                    valueChoose=="Add Work Timing"?
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          valueChoose="8 to 5";
                        });
                      },
                      child: Text('Set Default',style: Get.textTheme.caption!.merge(TextStyle(fontWeight: FontWeight.bold)),
                        textAlign: TextAlign.start,),
                    ):Container(),
                  ],
                ),
                valueChoose!="Add Work Timing"?
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined,color: Colors.grey.shade500,),
                    Expanded(
                      flex: 1,
                      child: DropdownButton(
                          underline: SizedBox(),
                          hint: Text(
                            'Please select working Time',
                            style: TextStyle(fontSize: size.width * nine),
                          ),
                          value: valueChoose,
                          icon: Icon(Icons.arrow_drop_down),
                          // iconSize: 36,
                          isExpanded: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * nine,
                              fontWeight: FontWeight.w500
                          ),
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: TextStyle(
                                    fontSize: size.width * ten,
                                    color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (
                              newValue,
                              ) {
                            setState(() {
                              valueChoose = newValue as String?;
                            });
                          }).marginOnly(left: 14.0,right: 0.0,top: 0.0,bottom: 0),
                    ),
                  ],
                ):Container(
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    // onSaved: onSaved,
                    // onChanged: onChanged,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                    style: Get.textTheme.bodyText2,
                    textAlign: TextAlign.start,
                    decoration: Ui.getInputDecoration(
                      hintText: 'Please enter working time',
                      iconData: Icons.watch_later_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
              decoration: BoxDecoration(
                  color: page,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Get.theme.focusColor.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5)),
                  ],
                  border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.05))),
              child: Column(children: [
                Container(
              alignment:Alignment.topLeft,
                  child: Row(
                    children: [
                      Expanded(
                        flex:3,
                        child: Text(
                          'Salary',
                          style: Get.textTheme.bodyText1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Text(
                          'Salary Type',
                          style: Get.textTheme.bodyText1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      // onSaved: onSaved,
                      // onChanged: onChanged,
                      validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                      style: Get.textTheme.bodyText2,
                      textAlign: TextAlign.start,
                      decoration: Ui.getInputDecoration(
                        hintText: 'Please enter salary',
                        iconData: Icons.monetization_on_outlined,
                      ),
                    ),),
                    Expanded(
                      flex: 1,
                      child: DropdownButton(
                          underline: SizedBox(),
                          hint: Text(
                            'Type',
                            style: TextStyle(fontSize: size.width * nine),
                          ),
                          value: valueChoose1,
                          icon: Icon(Icons.arrow_drop_down),
                          // iconSize: 36,
                          isExpanded: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * nine,
                              /*fontWeight: FontWeight.w500*/
                          ),
                          items: listItem1.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: TextStyle(
                                    fontSize: size.width * ten,
                                    color: textColor),
                              ),
                            );
                          }).toList(),
                          onChanged: (
                              newValue,
                              ) {
                            setState(() {
                              valueChoose1 = newValue as String?;
                            });
                          }),
                    ),
                  ],
                )
                // Expanded(
                //   flex:1,
                //   child:TextFieldWidget(
                //     labelText: "Please enter salary".tr,
                //     hintText: "Please enter salary".tr,
                //     // initialValue: (controller.currentUser.value.password)!,
                //     // onSaved: (input) => controller.currentUser.value.password = input,
                //     validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                //     // obscureText: controller.hidePassword.value,
                //     iconData: Icons.lock_outline,
                //     keyboardType: TextInputType.phone,
                //     isLast: true,
                //     isFirst: false,
                //     // suffixIcon: Icons.monetization_on_outlined,
                //   )
                // ),
                // Expanded(
                //   flex:1,
                //   child:TextFieldWidget(
                //     labelText: "Please enter salary".tr,
                //     hintText: "Please enter salary".tr,
                //     // initialValue: (controller.currentUser.value.password)!,
                //     // onSaved: (input) => controller.currentUser.value.password = input,
                //     validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                //     // obscureText: controller.hidePassword.value,
                //     iconData: Icons.lock_outline,
                //     keyboardType: TextInputType.phone,
                //     isLast: true,
                //     isFirst: false,
                //     // suffixIcon: Icons.monetization_on_outlined,
                //   )
                // ),
              ])),
        ],
      ),
    );
  }

}

