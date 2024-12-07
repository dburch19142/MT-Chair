import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  bool isLoading = false;

  void addService() async {
    if (price.text.isEmpty || title.text.isEmpty) {
      return showErrorToast('Please fill all form');
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool res = await DatabaseService.addService(
        title: title.text,
        price: price.text,
      );

      if (res) {
        showToast('Service added successfully');
        setState(() {
          isLoading = false;

          title.clear();
          price.clear();
        });
      } else {
        showErrorToast('Error adding service');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
    String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: bg == ''
              ? const DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: NetworkImage(bg),
                  fit: BoxFit.cover,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   'assets/images/logo.png',
                    //   width: width(context) / 3,
                    // ),
                    // SizedBox(
                    //   height: height(context) * .1,
                    // ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        width: width(context),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBoxH20(),
                            Text(
                              'Service Name',
                              style: textStyle14,
                            ),
                            const SizedBoxH10(),
                            CustomTextField(
                              hintText: 'Enter service name',
                              controller: title,
                            ),
                            const SizedBoxH20(),
                            Text(
                              'Service Price',
                              style: textStyle14,
                            ),
                            const SizedBoxH10(),
                            CustomTextField(
                              hintText: 'Enter service price',
                              controller: price,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBoxH20(),
                            isLoading
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: red,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: SizedBox(
                                      width: 150,
                                      child: CustomButton(
                                        onPressed: () {
                                          addService();
                                        },
                                        text: 'Add Service',
                                        textColor: white,
                                        bgColor: green,
                                      ),
                                    ),
                                  ),
                            const SizedBoxH20(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    text: 'Back',
                                    textColor: white,
                                    bgColor: red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
