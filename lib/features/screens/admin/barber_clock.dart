import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/collections.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClockSelectBarberScreen extends StatefulWidget {
  const ClockSelectBarberScreen({super.key});

  @override
  State<ClockSelectBarberScreen> createState() =>
      _ClockSelectBarberScreenState();
}

class _ClockSelectBarberScreenState extends State<ClockSelectBarberScreen> {
  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('empty').get('logo', defaultValue: '');
    String bg = Hive.box('empty').get('bg', defaultValue: '');
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
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select barber',
                            style: textStyle14.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        height: height(context) * .6,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: DatabaseService().getAllBarbersStream(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('No barber available'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: red,
                                    ),
                                  ),
                                );
                              }
                              return snapshot.data!.docs.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'No barber available, please add barber'),
                                    )
                                  : GridView.builder(
                                      // scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      controller: ScrollController(
                                          keepScrollOffset: false),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            constraints.maxWidth <= 768 ? 2 : 4,
                                        mainAxisSpacing: 20.0,
                                        crossAxisSpacing: 80.0,
                                        childAspectRatio: 0.64,
                                      ),
                                      itemBuilder: (context, index) {
                                        var data = snapshot.data!.docs;
                                        return Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Image.network(
                                                      data[index]['photo_url'],
                                                      // width: width(context),
                                                      // height: 110,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBoxH5(),
                                              InkWell(
                                                onTap: () async {
                                                  await FireCollections
                                                      .barberRef
                                                      .doc(data[index]['id'])
                                                      .update({
                                                    "available": !data[index]
                                                        ['available'],
                                                  });
                                                },
                                                child: Container(
                                                  width: width(context),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 6,
                                                    vertical: 5,
                                                  ),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: data[index]
                                                            ['available']
                                                        ? green
                                                        : red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Text(
                                                    data[index]['available']
                                                        ? "Available"
                                                        : "Unavailable",
                                                    style: textStyle14.copyWith(
                                                      color: white,
                                                      fontSize: constraints
                                                                  .maxWidth <=
                                                              768
                                                          ? 10
                                                          : 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                            }),
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
                              text: 'Home',
                              textColor: white,
                              bgColor: green,
                            ),
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
