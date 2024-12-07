import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/features/screens/admin/client_admin/update_hour.dart';
import 'package:emptychair/features/screens/admin/client_admin/update_service.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBoxH20(),
                            StreamBuilder<QuerySnapshot>(
                                stream: DatabaseService().getServices(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: Text('No data'),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }
                                  return snapshot.data!.docs.isEmpty
                                      ? const Center(
                                          child: Text('No data'),
                                        )
                                      : ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var data =
                                                snapshot.data!.docs[index];
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: textStyle16
                                                            .copyWith(),
                                                      ),
                                                      Text(
                                                        '\$${data['price']}',
                                                        style: textStyle12
                                                            .copyWith(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            UpdateServiceScreen(
                                                              id: data['id'],
                                                              name:
                                                                  data['name'],
                                                              price:
                                                                  data['price'],
                                                            ));
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color: blue,
                                                      ),
                                                    ),
                                                    const SizedBoxW10(),
                                                    InkWell(
                                                      onTap: () {
                                                        showDeleteModal(
                                                            data['id']);
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemCount: snapshot.data!.docs.length,
                                        );
                                }),
                            const SizedBoxH20(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.toNamed(AppPages.addService);
                                    },
                                    text: 'Add Service',
                                    textColor: white,
                                    bgColor: green,
                                  ),
                                ),
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

  void showDeleteModal(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
            'Are you sure you want to delete this item?',
            style: textStyle14,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                DatabaseService.deleteService(id: id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
