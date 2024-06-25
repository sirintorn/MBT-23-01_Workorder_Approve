// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:web_project1/Provider/apiservice.dart';
import 'package:web_project1/Provider/userlogin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Provider/colore_provider.dart';
import '../demo-1-screen/common_layout.dart';

class Widget_Screen_1 extends StatefulWidget {
  const Widget_Screen_1({super.key});

  @override
  State<Widget_Screen_1> createState() => _Widget_Screen_1State();
}

ColorNotifire notifire = ColorNotifire();

class _Widget_Screen_1State extends State<Widget_Screen_1> {
  late List<dynamic> machines = [];
  late dynamic user;

  TextEditingController nameController = TextEditingController();
  TextEditingController ipAddressController = TextEditingController();

  void loadData() async {
    user = await UserLoginProvider().getUser();
    machines = await APIService.getAllMachines();

    print(jsonEncode(machines));

    setState(() {});
  }

  void commitNewMachine() async {
    var item = await APIService.addMachine(
        nameController.text, ipAddressController.text, user['id']);
    setState(() {
      machines.add(item);
      // 👈 add list item to the list
    });
    Navigator.pop(context);
  }

  void _addMachineDialog() {
    var dialog = Dialog(
        insetPadding: EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 500,
              height: 360,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(children: [
                const ListTile(title: Text('Add new machine')),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration:
                        const InputDecoration(hintText: "Enter machine name"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: TextField(
                    controller: ipAddressController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        hintText: "Enter machine IP Address"),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ListTile(
                    leading: TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    trailing: TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        commitNewMachine();
                      },
                    ))
              ]),
            ),
          ],
        ));
    showDialog(context: context, builder: (context) => dialog);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mainrow(),
          const SizedBox(
            height: 20,
          ),
          if (machines.isEmpty == true)
            const SpinKitRotatingCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          if (machines.isEmpty == false) commoncontain8(),
          const SizedBox(
            height: 20,
          ),
          //------------------------------:-
        ],
      ),
    );
  }

  String? selectedOption;

  List<String> dropdownOptions = [
    "1",
    "2",
    "3",
  ];

  //---------------------------------------------------------------:-

  Widget dropdownbuton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              padding: const EdgeInsets.only(left: 10),
              items: dropdownOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              decoration: InputDecoration(
                hintText: '30 days',
                hintStyle: TextStyle(color: notifire.textcolore),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commoncontain11() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: notifire.containcolore1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                        image: const AssetImage('assets/chart-trend-up.png'),
                        color: notifire.textcolore),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text('Transaction History',
                            style: TextStyle(
                                fontSize: 15, color: notifire.textcolore),
                            overflow: TextOverflow.ellipsis)),
                    const Spacer(flex: 3),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color(0xffE1F7E9),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              'Option',
                              style: TextStyle(color: Colors.green),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.arrow_right_alt, color: Colors.white),
                  ),
                  Text(
                    '54',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: notifire.textcolore),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pending Invoices',
                    style: TextStyle(color: notifire.textcolore),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Text('Invoice details',
                    style: TextStyle(color: notifire.textcolore)),
                trailing: dropdownbuton(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                  Text(
                    '28',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: notifire.textcolore),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.arrow_downward, color: Colors.white),
                      ),
                      Text(
                        '32',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: notifire.textcolore),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Invoices In',
                      style: TextStyle(color: notifire.textcolore)),
                  const SizedBox(
                    width: 60,
                  ),
                  Row(
                    children: [
                      Text('Invoices Out',
                          style: TextStyle(color: notifire.textcolore)),
                    ],
                  )
                ],
              ),
              ListTile(
                leading: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 15,
                      color: Colors.white,
                    )),
                title: Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text('Invoice 1',
                        style: TextStyle(color: notifire.textcolore))),
                trailing: Text('+1,235',
                    style: TextStyle(color: notifire.textcolore)),
              ),
              ListTile(
                leading: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.arrow_downward,
                      size: 15,
                      color: Colors.white,
                    )),
                title: Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text('Invoice 2',
                        style: TextStyle(color: notifire.textcolore))),
                trailing:
                    Text('-152', style: TextStyle(color: notifire.textcolore)),
              ),
              ListTile(
                leading: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.arrow_downward,
                      size: 15,
                      color: Colors.white,
                    )),
                title: Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text('Invoice 3',
                        style: TextStyle(color: notifire.textcolore))),
                trailing: Text('+13,487',
                    style: TextStyle(color: notifire.textcolore)),
              ),
              ListTile(
                leading: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 15,
                      color: Colors.white,
                    )),
                title: Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text('Invoice 4',
                        style: TextStyle(color: notifire.textcolore))),
                trailing: Text('-1,523',
                    style: TextStyle(color: notifire.textcolore)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SampleItem? selectedMenu;

  Widget commoncontain8() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: notifire.containcolore1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, right: 10),
              child: Row(
                children: [
                  Image(
                      image: const AssetImage('assets/bell.png'),
                      color: notifire.textcolore),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Machines',
                    style: TextStyle(fontSize: 15, color: notifire.textcolore),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xffE1F7E9),
                        borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton.icon(
                        onPressed: _addMachineDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            overflow: TextOverflow.ellipsis)),
                  ),
                  const Expanded(
                      child: SizedBox(
                    width: 5,
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 600,
              child: ListView.builder(
                itemCount: machines.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.account_tree_outlined),
                    title: Text('${machines[index]['name']}'),
                    subtitle: Text('${machines[index]['ipAddress']}'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget mainrow() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            // color: Colors.red,
            height: 50,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Add Machine',
                    style: TextStyle(
                        fontFamily: 'Jost-SemiBold',
                        fontSize: 20,
                        color: notifire.textcolore,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
              ),
              trailing: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 60,
                  width: 95,
                  child: Row(
                    children: [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

//------------------------------------------------------------
//COMMON CODE//
}
