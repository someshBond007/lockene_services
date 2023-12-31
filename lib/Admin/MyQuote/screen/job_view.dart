import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service/Admin/MyQuote/widgets/booking_actions_widget.dart';
import 'package:service/Admin/MyQuote/widgets/booking_row_widget.dart';
import 'package:service/Admin/MyQuote/widgets/booking_til_widget.dart';
import 'package:service/Admin/MyQuote/widgets/booking_title_bar_widget.dart';
import 'package:service/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

// import 'package:syncfusion_flutter_sliders/sliders.dart';


import '../../../features/Map/map_utils.dart';
import '../../../features/common/ui.dart';
import '../../../styles/styles.dart';
import '../controller/jobview_controller.dart';
import '../controller/viewquote_controller.dart';


class JobView extends GetView<JobViewController> {

  var title = "job";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BookingActionsWidget(title),
      body: RefreshIndicator(
          onRefresh: () async {
            controller.refreshBooking(showMessage: true);
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 370,
                elevation: 0,
                // pinned: true,
                floating: true,
                iconTheme: IconThemeData(color: Get.theme.primaryColor),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                  onPressed: () {
                    Get.find<ViewQuoteController>().refreshHome();
                    Get.back();
                  },
                ),
                actions: [
                  MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      MapUtils.openMap(21.142339, 79.06958);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.orange,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      children: [
                        Icon(Icons.map_outlined, color: Colors.white),
                        Text("On Maps".tr, style: Get.textTheme.bodyText2!.merge(TextStyle(color: Colors.white))),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 20, vertical: 8)
                ],                bottom: buildBookingTitleBarWidget(/*controller.booking*/),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background:  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(width: 5, color: page),
                      color: textColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        'https://kfmindia.in/wp-content/uploads/2017/05/garden_maintenance.jpg',
                        // 'http://www.evergreenlandscaping.in/wp-content/uploads/2018/09/garden-maintenance-e1537548069918.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 500,
                      ),
                    ),
                  ).marginSymmetric(horizontal: 10.0,vertical: 80.0),),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildContactCustomer(),
                    BookingTilWidget(
                      title: Text("Booking Details".tr, style: Get.textTheme.subtitle2),
                      actions: [Text("# " + "786", style: Get.textTheme.subtitle2)],
                      content: Column(
                        children: [
                          BookingRowWidget(
                              descriptionFlex: 1,
                              valueFlex: 2,
                              description: "Req. Type".tr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Get.theme.focusColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      /*controller.booking.value.status!.status!*/"Servicing",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              hasDivider: true),
                          BookingRowWidget(
                              descriptionFlex: 1,
                              valueFlex: 2,
                              description: "Req. Status".tr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Get.theme.focusColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      /*controller.booking.value.status!.status!*/"On the way",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              hasDivider: true),
                          BookingRowWidget(
                              descriptionFlex: 1,
                              valueFlex: 2,
                              description: "Type".tr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Get.theme.focusColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      "Dedicated",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              hasDivider: true),
                          BookingRowWidget(
                              descriptionFlex: 1,
                              valueFlex: 2,
                              description:"Payment Status".tr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Get.theme.focusColor.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      "Not paid",
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(color:  Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              hasDivider: true),
                          BookingRowWidget(
                              descriptionFlex: 1,
                              valueFlex: 2,
                              description: "Track".tr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 0, left: 12),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.TRACKSTATUS);

                                      },
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      color: Colors.orange,
                                      child: Text(
                                        "View".tr, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),

                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ],
                              ),
                              hasDivider: false),

                        ],
                      ),
                    ),
                    BookingTilWidget(
                        title: Text("Booking Date & Time".tr, style: Get.textTheme.subtitle2),

                        content: Column(
                          children: [
                            BookingRowWidget(
                                description: "Booking on".tr,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("8 Feb 2023,  12:25",
                                      style: Get.textTheme.caption!.merge(TextStyle(fontWeight: FontWeight.w500)),
                                      textAlign: TextAlign.end,
                                    )),
                                hasDivider: true),
                            // if (controller.booking.value.startAt != null)
                            BookingRowWidget(
                                description: "Service Scheduled on".tr,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "8 Feb 2023,  3:25",
                                      style: Get.textTheme.caption!.merge(TextStyle(fontWeight: FontWeight.w500)),
                                      textAlign: TextAlign.end,
                                    )),
                                hasDivider: false),
                          ],
                        )
                      // ;}),
                    ),
                    BookingTilWidget(
                      title: InkWell(
                        onTap: (){
                          Get.toNamed(Routes.ALL_LINE,arguments: "jobview");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Line Item".tr, style: Get.textTheme.subtitle2),
                            Text("Add More".tr, style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.orange))),
                          ],
                        ),
                      ),
                      content: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Get.toNamed(Routes.EDIT_LINE,arguments: "jobview");
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Floor Cleaning".tr, style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.orange))).paddingSymmetric(vertical: 2.5),
                                  Text("Description regarding work xyz".tr, maxLines: 3,style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.grey.shade600))).paddingSymmetric(vertical: 5.0),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('1 x ₹ 5110',style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.black))),Text('₹ 5000')],).marginOnly(bottom: 2.5)
                                ],),),
                          ),
                          Divider(color: Colors.grey.shade400,),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Plant Cutting".tr, style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.orange))).paddingSymmetric(vertical: 2.5),
                                Text("Description regarding work xyz".tr, maxLines: 3,style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.grey.shade600))).paddingSymmetric(vertical: 5.0),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('1 x ₹ 5110',style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.black))),Text('₹ 5000')],).marginOnly(bottom: 2.5)
                              ],),),
                          Divider(color: Colors.grey.shade400,),
                          GestureDetector(
                            onTap: (){
                              // BookingWarrantyWidget();
                              // print("Warranty");
                              // _showAlertDialog(context,controller);

                            },
                            child: Column(
                              children: List.generate(/*controller.booking.value.taxes!.length*/1, (index) {
                                var _tax = /*controller.booking.value.taxes!.elementAt(index)*/"20";
                                return BookingRowWidget(
                                    description:"Warranty type",
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:
                                      GestureDetector(
                                          onTap: (){
                                            _showAlertDialog(context,controller);

                                          },
                                          child: Text("Click for view", style: Get.textTheme.bodyText1,)),
                                    ), hasDivider: true).paddingOnly(top: 5.0);
                              }),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _showAlertDialogBill(context,controller);
                              print("hi");
                            },
                            child: Column(
                              children: List.generate(/*controller.booking.value.taxes!.length*/1, (index) {
                                var _tax = /*controller.booking.value.taxes!.elementAt(index)*/"20";
                                return BookingRowWidget(
                                    description:"Bill",
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:
                                      Text("Click for view", style: Get.textTheme.bodyText1,),
                                    ),
                                    hasDivider: true);
                              }),
                            ),
                          ),
                          BookingRowWidget(
                              descriptionFlex: 2,
                              valueFlex: 1,
                              description: /*controller.booking.value.eService!.name!*/"Service charge",
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("1220",
                                  style: Get.textTheme.bodyText2!.merge(TextStyle(color: Colors.grey.shade800)),
                                ),
                              ),
                              hasDivider: true),
                          BookingRowWidget(
                              description: "Quantity".tr,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "x 1" + /*controller.booking.value.quantity.toString() + */"" /*+ controller.booking.value.eService!.quantityUnit!.tr*/,
                                  style: Get.textTheme.bodyText2!.merge(TextStyle(color: Colors.grey.shade800)),
                                ),
                              ),
                              hasDivider: true),

                          //   BookingRowWidget(
                          //   description: "Tax Amount".tr,
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Text(/*controller.booking.value.getTaxesValue()*/"GST",
                          //       style: Get.textTheme.bodyText2!.merge(TextStyle(color: Colors.grey.shade800)),
                          //     ),
                          //   ),
                          //   hasDivider: false,
                          // ),

                          BookingRowWidget(
                              description: "Subtotal".tr,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("₹ "+"1220"),
                              ),
                              hasDivider: true),
                          //   ;
                          // }),
                          // if ((controller.booking.value.coupon?.discount ?? 0) > 0)

                          //   BookingRowWidget(
                          //       description: "Coupon".tr,
                          //       child: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Wrap(
                          //           children: [
                          //             Text(' - ', style: Get.textTheme.bodyText1),
                          //             Text(/*controller.booking.value.coupon!.discount!*/"5%",
                          //               style: Get.textTheme.bodyText2!.merge(TextStyle(color: Colors.grey.shade800)),)
                          //           ],
                          //         ),
                          //       ),
                          //       hasDivider: true),

                          // Obx(() {
                          //   return
                          BookingRowWidget(
                            description: "Total Amount".tr,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("₹ "+"1220",
                                  style: Get.textTheme.headline6!.merge(TextStyle(color: Colors.orange)),
                              ),
                            ),
                          )
                          // ;
                          //                           }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: Ui.getBoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Team'.tr, style: Get.textTheme.subtitle2).marginOnly(bottom: 5.0),
                              GestureDetector(onTap: (){
                                print("update");
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return UpdateTeamDialog();
                                    });
                              },
                                  child: Text('Update'.tr, style: Get.textTheme.subtitle2!.merge(TextStyle(color: Colors.orange))).paddingOnly(left: 10,bottom: 5.0)),
                            ],
                          ),
                          Container(
                            // height: 80,
                            child: Row(
                              children: [
                                Icon(Icons.person,color: Colors.orange,size: 30,).paddingOnly(right: 10.0),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Ankush Thengne',style:Get.textTheme.subtitle2!,),
                                          Text('Web Developer',style: TextStyle(color: Colors.grey.shade600),),

                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ).marginOnly(top: 10.0),
                        ],
                      ),
                    ),





                  ],
                ),
              ),
            ],
          )),
    );

  }



  BookingTitleBarWidget buildBookingTitleBarWidget(/*Rx<Booking> _booking*/) {
    return BookingTitleBarWidget(
      title:
      // Obx(() {
      //   return
          Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    'Garden Cleaning',
                    style: Get.textTheme.headline5!.merge(TextStyle(height: 1.1)),
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: Colors.grey),
                      SizedBox(width: 8),
                      AutoSizeText('Ankush Thengne',
                        style: Get.textTheme.bodyText1!.merge(TextStyle(color:Colors.grey)),
                        maxLines: 1,
                        overflow:TextOverflow.fade,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.place_outlined, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText('Bung. No 54,Vani', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color:Colors.grey)).paddingOnly(right: 10.0),
                      ),
                    ],
                    // spacing: 8,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                  ),
                ],
              ),
            ),
              Container(
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(/*DateFormat('HH:mm', Get.locale.toString()).format(_booking.value.bookingAt!)*/"12:30",
                        maxLines: 1,
                        style: Get.textTheme.bodyText2!.merge(
                          TextStyle(color: Colors.orange, height: 1.4),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    Text(/*DateFormat('dd', Get.locale.toString()).format(_booking.value.bookingAt! ?? '')*/"28",
                        maxLines: 1,
                        style: Get.textTheme.headline4!.merge(
                          TextStyle(color: Colors.orange, height: 1),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                    Text(/*DateFormat('MMM', Get.locale.toString()).format(_booking.value.bookingAt ?? '')*/"Feb",
                        maxLines: 1,
                        style: Get.textTheme.bodyText2!.merge(
                          TextStyle(color: Colors.orange, height: 1),
                        ),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              ),
          ],
        )
        // ;}),
    );
  }

  Container buildContactCustomer(/*Booking _booking*/) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: Ui.getBoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Text("Contact Customer".tr, style: Get.textTheme.subtitle2),
          ),
          Wrap(
            spacing: 5,
            children: [
              MaterialButton(
                onPressed: () {
                  // launchUrlString("tel:'9689455261'}");
                  UrlLauncher.launch("tel://9689455261");
                },
                height: 44,
                minWidth: 44,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.orange.shade300,
                child: Icon(
                  Icons.phone_android_outlined,
                  color: page,
                ),
                elevation: 5,
              ),
              MaterialButton(
                onPressed: () {
                  launch('mailto:rajatmeshrams11@gmail.com?''subject=From Mistrichacha services');
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.orange.shade300,
                padding: EdgeInsets.zero,
                height: 44,
                minWidth: 44,
                child: Icon(
                  Icons.mail,
                  color: page,
                ),
                elevation: 5,
              ),
            ],
          )
        ],
      ),
    );
  }

}


class UpdateTeamDialog extends StatefulWidget {
  const UpdateTeamDialog({Key? key}) : super(key: key);

  @override
  State<UpdateTeamDialog> createState() => _UpdateTeamDialogState();
}

class _UpdateTeamDialogState extends State<UpdateTeamDialog> {

  String? valueChoose;
  List listItem = [
    'Sanket Ukey',
    'Ankush Thengene',
    'Vikas Dubey',
    'Shashank Rao',
  ];
  var process;
  var date="";
  var time="";

  DateTime ? _selectedDate;
  TimeOfDay? _selectedTime /*= TimeOfDay.now()*/;


  void _pickDateDialog(BuildContext context) {

    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        lastDate : DateTime(2051),

        firstDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  //Method for showing the time picker
  void _showTimePicker() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // builder: (context, child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: ColorScheme.light(
      //         // change the border color
      //         primary: Colors.orange,
      //         // change the text color
      //         onSurface: Colors.black,
      //       ),
      //       // button colors
      //       buttonTheme: ButtonThemeData(
      //         colorScheme: ColorScheme.light(
      //           primary: Colors.green,
      //         ),
      //       ),
      //     ),
      //     child: child!,
      //   );
      // },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AlertDialog(
      scrollable: true,

      contentPadding: EdgeInsets.zero,
      title: Text('Update Team'),
      content: Container(
        width: size.width * 0.9,
        // height: size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Team Member').marginOnly(top: 20.0,bottom: 0),
            DropdownButton(
              isDense: true,
                hint: Text(
                  'Please select member',
                  style: TextStyle(fontSize: size.width * twelve),
                ),
                value: valueChoose,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 28,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width * twelve,
                ),

                items: listItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(
                      valueItem,
                      style: TextStyle(
                          fontSize: size.width * twelve,
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
                }
                ).marginOnly(top: 5.0,bottom: 0),
            // Text('Service Date').marginOnly(top: 10.0,bottom: 0),
            //
            // Row(
            //   children: [
            //     Icon(Icons.calendar_today_rounded).marginOnly(right: 10.0),
            //     if(_selectedDate == null)
            //     GestureDetector(
            //       onTap: () => _pickDateDialog(context),
            //         child: Text('Please select service date.',style: TextStyle(color: Colors.grey.shade600),)),
            //     if(_selectedDate != null)
            //     GestureDetector(
            //       onTap: (){
            //         _pickDateDialog(context);
            //       },
            //         child: Container(width:size.width*0.6,
            //             child: Text('${DateFormat.yMMMd().format(_selectedDate!)}'))),
            //   ],
            // ).marginOnly(top: 5.0),
            // Text('Service Time').marginOnly(top: 10.0,bottom: 0),
            // Row(
            //   children: [
            //     Icon(Icons.alarm).marginOnly(right: 10.0),
            //     if(_selectedTime == null)
            //       GestureDetector(
            //           onTap: () => _showTimePicker(),
            //           child: Text('Please select service time.',style: TextStyle(color: Colors.grey.shade600),)),
            //     if(_selectedTime != null)
            //       GestureDetector(
            //           onTap: (){
            //             _showTimePicker();
            //           },
            //           child: Container(
            //               width:size.width*0.6,
            //               child: Text(_selectedTime!.format(context)))),
            //   ],
            // ).marginOnly(top: 5.0),

            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: size.width * fourteen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: size.width*0.05),
      ),
    );

  }
}

void _showAlertDialog(BuildContext context, [JobViewController ? controller]) {
  String? valueChoose;
  var size = MediaQuery.of(context).size;
  List listItem = [
    'On the way',
    'In process',
    'Worked completed',
    'Not served',
  ];
  final url = "https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview";

  _save() async {
    var status = await Permission.storage.request();
    if(status.isGranted){
      var response = await Dio().get(
          url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    }

  }


  final TextEditingController _remarkController = TextEditingController();

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return
            AlertDialog(
              scrollable: true,
              contentPadding: EdgeInsets.zero,
              title: Text('Warranty Details'),
              content: Container(
                width: size.width * 0.9,
                // height: size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Text('Warranty :',style: TextStyle(fontWeight: FontWeight.w500,),),
                        Text(' Under Warranty'),
                      ],
                    ).marginSymmetric(horizontal: 20.0),
                    Text('Warranty Document :',style: TextStyle(fontWeight: FontWeight.w500,),).marginSymmetric(horizontal: 20.0),
                    Container(
                      // color: Colors.black,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 160,
                        imageUrl:/* _currentUser.value.avatar?.thumb ?? */'https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview',
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 160,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                      ),
                    ).paddingSymmetric(horizontal: 10.0),
                    // Image.network('https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview').paddingSymmetric(horizontal: 10.0,vertical: 5.0),

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        controller!.downloadStart(showMessage: true);
                        _save();

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Text(
                            'Download',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: size.width * fourteen,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cancel',style:
                          TextStyle(fontWeight: FontWeight.w500,decoration: TextDecoration.underline,
                          ),textAlign: TextAlign.center,).paddingOnly(left: 20.0,bottom: 20,right: 20.0,top: 5.0),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
        });
      });
}

void _showAlertDialogBill(BuildContext context, [JobViewController ? controller]) {
  String? valueChoose;
  var size = MediaQuery.of(context).size;
  List listItem = [
    'On the way',
    'In process',
    'Worked completed',
    'Not served',
  ];
  final url = "https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview";

  _save() async {
    var status = await Permission.storage.request();
    if(status.isGranted){
      var response = await Dio().get(
          url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
    }

  }


  final TextEditingController _remarkController = TextEditingController();

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return
            AlertDialog(
              scrollable: true,
              contentPadding: EdgeInsets.zero,
              title: Text('Bill Details'),
              content: Container(
                width: size.width * 0.9,
                // height: size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    // Row(
                    //   children: [
                    //     Text('Warranty :',style: TextStyle(fontWeight: FontWeight.w500,),),
                    //     Text(' Under Warranty'),
                    //   ],
                    // ).marginSymmetric(horizontal: 20.0),
                    Text('Bill Document :',style: TextStyle(fontWeight: FontWeight.w500,),).marginSymmetric(horizontal: 20.0),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.ZOOMVIEW);
                      },
                      child: Container(
                        // color: Colors.black,
                        child:
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 160,
                          imageUrl:'https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview',
                          placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 160,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error_outline),
                        ),
                      ).paddingSymmetric(horizontal: 10.0),
                    ),
                    // Image.network('https://www.allaboutcards.de/mediathek/garantiekarte-hinten.png/image_preview').paddingSymmetric(horizontal: 10.0,vertical: 5.0),

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        _save();
                        controller!.downloadStart(showMessage: true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Text(
                            'Download',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: size.width * fourteen,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cancel',style:
                          TextStyle(fontWeight: FontWeight.w500,decoration: TextDecoration.underline,
                          ),textAlign: TextAlign.center,).paddingOnly(left: 20.0,bottom: 20,right: 20.0,top: 5.0),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
        });
      });
}




