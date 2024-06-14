// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:web_project1/Provider/apiservice.dart';
import 'package:web_project1/Provider/userlogin.dart';

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

    setState(() {});
  }

  void commitNewMachine() async{
    var item = await APIService.addMachine(nameController.text, ipAddressController.text, user['id']);
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
        )
        /*title: const Text('Add new machine'),
      content: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(children: [
          TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter machine name"),
          ),
          TextField(
            controller: ipAddressController,
            autofocus: true,
            decoration:
                const InputDecoration(hintText: "Enter machine IP Address"),
          ),
        ]),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            setState(() {
              // 👈 add list item to the list
            });
            Navigator.pop(context);
          },
        ),
      ],*/
        );
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: notifire.bgcolore,
      // color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(child: mainrow()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    commoncontain8() //NOTIFICATION
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //------------------------------:-
                Row(
                  children: [commoncontain9()],
                ),
                //------------------------------:-
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain10()],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    commoncontain11(),
                    commoncontain12(constraints.maxWidth),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    commoncontain13(
                        leadingimage: 'assets/coins.png',
                        titletext: 'Employee Amount',
                        trillingtext: '-2%',
                        titletext2: 'Total',
                        trillingtext2: '%65,880',
                        titletext3: 'Salse',
                        trillingtext3: '554'),
                    commoncontain13(
                        leadingimage: 'assets/layout-web-1.png',
                        titletext: 'Monthaly Income',
                        trillingtext: '+15%',
                        titletext2: 'Total',
                        trillingtext2: '\$1250',
                        titletext3: 'Active',
                        trillingtext3: '1120'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    commoncontain13(
                        leadingimage: 'assets/chart-bar.png',
                        titletext: 'Product Sales',
                        trillingtext: '+10%',
                        titletext2: 'Total',
                        trillingtext2: '\$2350',
                        titletext3: 'Last report',
                        trillingtext3: '\$502,100'),
                    commoncontain13(
                        leadingimage: 'assets/building.png',
                        titletext: 'Monthly Income',
                        trillingtext: '+10%',
                        titletext2: 'Total',
                        trillingtext2: '\$1250',
                        titletext3: 'Last report',
                        trillingtext3: '\$453,000'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    commoncontain14(
                        leadincontaincolore: const Color(0xffFFE7E7),
                        imgcolore: Colors.red,
                        img: 'assets/chart-line-up.png',
                        titletext: 'Total Earning',
                        subtitletext: 'From previous period',
                        trillingtext: '5,40,549'),
                    commoncontain14(
                        leadincontaincolore: const Color(0xffE5EBFA),
                        imgcolore: const Color(0xff4E7ADF),
                        img: 'assets/crown.png',
                        titletext: 'Sales',
                        subtitletext: 'From previous period',
                        trillingtext: '1,205,677'),
                    commoncontain14(
                        leadincontaincolore: const Color(0xffFFF8E8),
                        imgcolore: Colors.yellow,
                        img: 'assets/chart-bar-vertical.png',
                        titletext: 'Purchase',
                        subtitletext: 'From previous period',
                        trillingtext: '48,430,039'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain15()],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain16(size: constraints.maxWidth)],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain17(size: constraints.maxWidth)],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain18(size: constraints.maxWidth)],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [commoncontain19(size: constraints.maxWidth)],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
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

  Widget commoncontain1(
      {required String img,
      required Color color,
      required Color backgrounde,
      required double vle,
      required String titlefirst,
      required String subtitlefirst,
      required String titlesecounde,
      required String subtitlesecounde}) {
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
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xffE9ECEF),
                      borderRadius: BorderRadius.circular(65)),
                  child: Center(child: Image(image: AssetImage(img))),
                ),
                title: Text(
                  titlefirst,
                  style: TextStyle(fontSize: 25, color: notifire.textcolore),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(subtitlefirst,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: notifire.textcolore)),
                trailing: PopupMenuButton<SampleItem>(
                  initialValue: selectedMenu,
                  child: Icon(Icons.more_vert, color: notifire.textcolore),
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemOne,
                      child: Text('Action'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemTwo,
                      child: Text('Another Action'),
                    ),
                    const PopupMenuItem<SampleItem>(
                      value: SampleItem.itemThree,
                      child: Text('Something else Here'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Invoice Awaiting',
                    style: TextStyle(fontSize: 12, color: notifire.textcolore)),
                trailing: Text('\$5,569(56%)',
                    style: TextStyle(fontSize: 12, color: notifire.textcolore)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: backgrounde,
                  color: color,
                  value: vle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain2(
      {required String titlefirst,
      required String subtitlefirst,
      required Color clore,
      required String img}) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  titlefirst,
                  style: TextStyle(fontSize: 25, color: notifire.textcolore),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(subtitlefirst,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: clore, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image(
                      image: AssetImage(img),
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain3(
      {required String img,
      required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required Color containcolore,
      required Color txtcolore}) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: [
                    Image(image: AssetImage(img), color: notifire.textcolore),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      txt1,
                      style: TextStyle(color: notifire.textcolore),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(txt2,
                    style: TextStyle(fontSize: 25, color: notifire.textcolore)),
                trailing: Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                      // color: Color(0xffE1FBED),
                      color: containcolore,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    txt3,
                    style: TextStyle(color: txtcolore),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: [
                    const Text('Vs last month:',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      txt4,
                      style:
                          TextStyle(fontSize: 12, color: notifire.textcolore),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain4(
      {required String txt1,
      required Color color,
      required Color backgrounde,
      required double vle,
      required String txt3,
      required Color txtcolore,
      required Color containcolore}) {
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
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Row(
                  children: [
                    Text(txt1, style: TextStyle(color: notifire.textcolore)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: 30,
                // width: 200,
                child: ListTile(
                  title: Text('Invoice Awaiting',
                      style:
                          TextStyle(fontSize: 12, color: notifire.textcolore)),
                  trailing: Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                        // color: Color(0xffE1FBED),
                        color: containcolore,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      txt3,
                      style: TextStyle(color: txtcolore),
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: backgrounde,
                  color: color,
                  value: vle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain5(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String img,
      required Color imgcolore,
      required Color txtcolore}) {
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
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Row(
                  children: [
                    Text(txt1, style: TextStyle(color: notifire.textcolore)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text(txt2,
                        style: TextStyle(
                            fontSize: 25, color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Image(
                      image: AssetImage(img),
                      color: imgcolore,
                      height: 15,
                      width: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(txt3, style: TextStyle(color: txtcolore)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain6() {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Expanded(
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
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 220,
                      decoration: const BoxDecoration(
                        color: Color(0xffD7F4E2),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                        image: AssetImage('assets/laptop.png')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Flexible(
                                        child: Text(
                                      'Company income',
                                      style: TextStyle(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    const Spacer(flex: 3),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      color: const Color(0xffBFEED0),
                                      child: const Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Option',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_downward,
                                            color: Colors.green,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.green,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Text(
                                  '\$237,650',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.green),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xff4E7ADF),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          'All Earning',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 400,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TabBar(
                        unselectedLabelColor: notifire.textcolore,
                        labelColor: Colors.white,
                        indicator: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green),
                        tabs: const [
                          Text("March"),
                          Text("April"),
                          Text("May"),
                          Text("June"),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 280,
                  width: Get.width,
                  child: TabBarView(children: [
                    Column(
                      children: [
                        ListTile(
                          title: Text('\$23,050',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Annul companies taxes',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$46,50',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Avarage Product price',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$260,700',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Total annual profit before tax',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text('\$23,050',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Annul companies taxes',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$46,50',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Avarage Product price',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$260,700',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Total annual profit before tax',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text('\$23,050',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Annul companies taxes',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$46,50',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Avarage Product price',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$260,700',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Total annual profit before tax',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text('\$23,050',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Annul companies taxes',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$46,50',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Avarage Product price',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text('\$260,700',
                              style: TextStyle(color: notifire.textcolore)),
                          subtitle: Text('Total annual profit before tax',
                              style: TextStyle(color: notifire.textcolore)),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commoncontain7() {
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
                  children: [
                    Image(
                        image: const AssetImage('assets/ranking.png'),
                        color: notifire.textcolore),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Product Sales',
                      style:
                          TextStyle(fontSize: 15, color: notifire.textcolore),
                    ),
                    const Expanded(
                        child: SizedBox(
                      width: 5,
                    )),
                    Container(
                      height: 30,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEBEE),
                          borderRadius: BorderRadius.circular(5)),
                      child: PopupMenuButton<SampleItem>(
                        initialValue: selectedMenu,
                        child: const Icon(Icons.more_vert),
                        onSelected: (SampleItem item) {
                          setState(() {
                            selectedMenu = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemOne,
                            child: Text('Action'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemTwo,
                            child: Text('Another Action'),
                          ),
                          const PopupMenuItem<SampleItem>(
                            value: SampleItem.itemThree,
                            child: Text('Something else Here'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Sales growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text(
                      '62%',
                      style: TextStyle(color: notifire.textcolore),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.red,
                  value: 0.6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Product growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('34%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.blueAccent,
                  value: 0.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Market Share',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('40%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.yellow,
                  value: 0.5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Sales growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('89%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.black,
                  value: 0.6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Product growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('36%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.teal,
                  value: 0.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Market Share',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('48%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.deepPurpleAccent,
                  value: 0.5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Sales growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('78%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.deepOrangeAccent,
                  value: 0.6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Product growth',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('64%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.greenAccent,
                  value: 0.4,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('Market Share',
                        style: TextStyle(color: notifire.textcolore)),
                    const Expanded(
                        child: SizedBox(
                      width: 10,
                    )),
                    Text('46%', style: TextStyle(color: notifire.textcolore))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  color: Colors.pink,
                  value: 0.5,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // const Padding(
              //   padding: EdgeInsets.only(left: 10,right: 10),
              //   child: Row(
              //     children: [
              //       Text('Market Share'),
              //       Expanded(child: SizedBox(width: 10,)),
              //       Text('22%')
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 5,),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10,right: 10),
              //   child: LinearProgressIndicator(
              //     backgroundColor: Colors.grey.withOpacity(0.4),
              //     color: Colors.deepPurpleAccent,
              //     value: 0.5,
              //   ),
              // ),
              // SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain8() {
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
                  children: [
                    Image(
                        image: const AssetImage('assets/bell.png'),
                        color: notifire.textcolore),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Machines',
                      style:
                          TextStyle(fontSize: 15, color: notifire.textcolore),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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
                child: Expanded(
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
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain9() {
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
                  children: [
                    Image(
                        image: const AssetImage('assets/bell.png'),
                        color: notifire.textcolore),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Company summary',
                      style:
                          TextStyle(fontSize: 15, color: notifire.textcolore),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                          color: const Color(0xffE1F7E9),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text('June', style: TextStyle(color: Colors.green)),
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
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          // height: 100,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Server Load',
                                    style: TextStyle(color: Colors.grey)),
                                subtitle: Text('489',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: notifire.textcolore)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.green,
                                  value: 0.5,
                                ),
                              ),
                              ListTile(
                                title: Text('49.4% Avg',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          // height: 100,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Members online',
                                    style: TextStyle(color: Colors.grey)),
                                subtitle: Text('3,450',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: notifire.textcolore)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.red,
                                  value: 0.5,
                                ),
                              ),
                              ListTile(
                                title: Text('34.6% Avg',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          // height: 100,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Today`s revenue',
                                    style: TextStyle(color: Colors.grey)),
                                subtitle: Text('\$18,390',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: notifire.textcolore)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.yellow,
                                  value: 0.5,
                                ),
                              ),
                              ListTile(
                                title: Text('\$37,578 Avg',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                          // height: 100,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Expected Profit',
                                    style: TextStyle(color: Colors.grey)),
                                subtitle: Text('\$23,461',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: notifire.textcolore)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.grey.withOpacity(0.4),
                                  color: Colors.blueAccent,
                                  value: 0.5,
                                ),
                              ),
                              ListTile(
                                title: Text('3\$23,461 Avg',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain10() {
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
                  children: [
                    Image(
                        image: const AssetImage('assets/user.png'),
                        color: notifire.textcolore),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'User feeds',
                      style:
                          TextStyle(fontSize: 15, color: notifire.textcolore),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffEFF2F7),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(image: AssetImage('assets/avatar-1 11.png')),
                  ),
                ),
                title: Text('Airi Satou',
                    style: TextStyle(color: notifire.textcolore)),
                subtitle: Text('Accounted',
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xffE1F7E8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.green))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffEFF2F7),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(image: AssetImage('assets/avatar-2 11.png')),
                  ),
                ),
                title: Text('Cedric Kelly',
                    style: TextStyle(color: notifire.textcolore)),
                subtitle: Text('Senior Developer',
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xffE1F7E8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.green))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffEFF2F7),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(image: AssetImage('assets/avatar-3 2c.png')),
                  ),
                ),
                title: Text('Brielle Williamson',
                    style: TextStyle(color: notifire.textcolore)),
                subtitle: Text('Integration Speciallite',
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xffE1F7E8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.green))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffEFF2F7),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(image: AssetImage('assets/avatar-4 2m.png')),
                  ),
                ),
                title: Text('Sonya Frost',
                    style: TextStyle(color: notifire.textcolore)),
                subtitle: Text('Softwear Engineer',
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xffE1F7E8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text('Follow',
                          style: TextStyle(color: Colors.green))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain12(double size123) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: notifire.bgcolore,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              size123 < 700
                  ? Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3D65FF)
                              // image: const DecorationImage(image: AssetImage('assets/imagesop.jpeg'),fit: BoxFit.fill),
                              ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Need for some help?',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        'Contact Here',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: const Color(0xffFD82FF),
                            borderRadius: BorderRadius.circular(15),
                            // image: DecorationImage(image: AssetImage('assets/downloadga.png'),fit: BoxFit.fill)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Flexible(
                                        child: Text(
                                      'Uniswap in your\npocket',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                            child: Text(
                                          'Learn more',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage('assets/bg-05 1.png'),
                                fit: BoxFit.fill),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Need for some help?',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        'Contact Here',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // const Flexible(child: Padding(
                              //   padding: EdgeInsets.only(top: 100),
                              //   child: Image(image: AssetImage('assets/Imageqs.png'),height: 350,width: 300,),
                              // )),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff3D65FF)
                              // image: const DecorationImage(image: AssetImage('assets/imagesop.jpeg'),fit: BoxFit.fill),
                              ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Need for some help?',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        'Contact Here',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Spacer(),
                              const Flexible(
                                  child: Image(
                                image: AssetImage('assets/Imagehv.png'),
                                height: 200,
                                width: 300,
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: const Color(0xffFD82FF),
                            borderRadius: BorderRadius.circular(15),
                            // image: DecorationImage(image: AssetImage('assets/downloadga.png'),fit: BoxFit.fill)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Flexible(
                                        child: Text(
                                      'Uniswap in your\npocket',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                            child: Text(
                                          'Learn more',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Flexible(
                                  child: Image(
                                image: AssetImage(
                                    'assets/wallet_banner_phone_image 1.png'),
                                height: 250,
                                width: 300,
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage('assets/bg-05 1.png'),
                                fit: BoxFit.fill),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Need for some help?',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                          child: Text(
                                        'Contact Here',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Flexible(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 45),
                                child: Image(
                                  image: AssetImage('assets/Imagecall.png'),
                                  fit: BoxFit.fill,
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain13(
      {required String leadingimage,
      required String titletext,
      required String trillingtext,
      required String titletext2,
      required String trillingtext2,
      required String titletext3,
      required String trillingtext3}) {
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
                height: 10,
              ),
              ListTile(
                leading: Image(
                    image: AssetImage(leadingimage),
                    color: notifire.textcolore),
                title: Text(titletext,
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Text(trillingtext,
                    style: const TextStyle(color: Colors.green)),
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
                title: Text(titletext2,
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Text(trillingtext2,
                    style: TextStyle(color: notifire.textcolore)),
              ),
              ListTile(
                title: Text(titletext3,
                    style: TextStyle(color: notifire.textcolore)),
                trailing: Text(trillingtext3,
                    style: TextStyle(color: notifire.textcolore)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain14(
      {required Color imgcolore,
      required Color leadincontaincolore,
      required String img,
      required String titletext,
      required String subtitletext,
      required String trillingtext}) {
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: leadincontaincolore,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(image: AssetImage(img), color: imgcolore),
                  ),
                  title: Text(titletext,
                      style: TextStyle(color: notifire.textcolore)),
                  subtitle: Text(subtitletext,
                      style: TextStyle(color: notifire.textcolore)),
                  trailing: Text(trillingtext,
                      style: TextStyle(color: notifire.textcolore)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain15() {
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
              ListTile(
                leading: Text('Project Pipeline',
                    style: TextStyle(fontSize: 16, color: notifire.textcolore)),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 10,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                              )),
                          Expanded(
                              flex: 15,
                              child: Container(
                                color: Colors.red,
                              )),
                          Expanded(
                              flex: 20,
                              child: Container(
                                color: Colors.teal,
                              )),
                          Expanded(
                              flex: 25,
                              child: Container(
                                color: Colors.yellow,
                              )),
                          Expanded(
                              flex: 10,
                              child: Container(
                                color: Colors.blue,
                              )),
                          Expanded(
                              flex: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.4),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                              )),
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(65)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text(
                    'Workinge',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: notifire.textcolore),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(65)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text('Pendinge',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: notifire.textcolore))),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(65)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text('In Progress',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: notifire.textcolore))),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(65)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text('Blocked',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: notifire.textcolore))),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(65)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Text('Remaininge',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: notifire.textcolore))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain16({required double size}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image(
                      image: const AssetImage('assets/user.png'),
                      color: notifire.textcolore),
                  Text('Human resource',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: notifire.textcolore)),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      "Manger",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  size < 800
                      ? const SizedBox()
                      : Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                            "Employee",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Container(
                    height: 350,
                    width: size < 1000 ? 1200 : size,
                    decoration: BoxDecoration(
                      color: notifire.containcolore1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            // border: TableBorder.all(color: Colors.black),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(100),
                              1: FixedColumnWidth(100),
                              2: FixedColumnWidth(100),
                            },
                            children: [
                              _row(),
                              _row1(),
                              _row2(),
                              _row3(),
                              _row4(),
                            ],
                          ),
                        ),
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

  Widget commoncontain17({required double size}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image(
                      image: const AssetImage('assets/rotate-circle.png'),
                      color: notifire.textcolore),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Order Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/filter.png'))),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Container(
                    height: 300,
                    width: size < 1000 ? 1200 : size,
                    decoration: BoxDecoration(
                      color: notifire.containcolore1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Table(
                            // border: TableBorder.all(color: Colors.black),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(10),
                              1: FixedColumnWidth(10),
                              2: FixedColumnWidth(200),
                              3: FixedColumnWidth(20),
                              4: FixedColumnWidth(20),
                              5: FixedColumnWidth(20),
                              6: FixedColumnWidth(20),
                            },
                            children: [
                              secoundtable1(),
                              const TableRow(children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ]),
                              secoundtable2(),
                              const TableRow(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                              secoundtable3(),
                              const TableRow(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                              secoundtable4(),
                              const TableRow(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                              secoundtable5(),
                              const TableRow(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                              secoundtable6(),
                            ],
                          ),
                        ),
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

  Widget commoncontain18({required double size}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image(
                      image: const AssetImage('assets/list.png'),
                      color: notifire.textcolore),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('Lastest log',
                      style: TextStyle(color: notifire.textcolore)),
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
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                size < 600
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('12 new users',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('12 new users registered',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      ),
                                const Spacer(),
                                Text('Just Now',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.green, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                size < 800
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('System',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('System shutdown',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 20,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffE3F6F2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                        child: Text(
                                      "Pendinge",
                                      style: TextStyle(color: Colors.green),
                                    ))),
                                const Spacer(),
                                Text('2 mins',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border:
                            Border.all(color: Colors.greenAccent, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('New invoice recvied',
                                      style: TextStyle(
                                          color: notifire.textcolore)),
                                ),
                                const Spacer(),
                                Text('3 mins',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.green, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                size < 800
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('New order',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text('New order recevied',
                                            style: TextStyle(
                                                color: notifire.textcolore)),
                                      ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Urgent",
                                      style: TextStyle(color: Colors.red),
                                    ))),
                                const Spacer(),
                                Text('10 mins',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.red, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('Production server',
                                      style: TextStyle(
                                          color: notifire.textcolore)),
                                ),
                                const Spacer(),
                                Text('1 hrs',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.yellow, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('System error check',
                                      style: TextStyle(
                                          color: notifire.textcolore)),
                                ),
                                const Spacer(),
                                Text('2 hrs',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.blue, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('DB overloaded 80%',
                                      style: TextStyle(
                                          color: notifire.textcolore)),
                                ),
                                const Spacer(),
                                Text('5 hrs',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.black, width: 4)),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TimelineTile(
                  endChild: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text('Production server up',
                                      style: TextStyle(
                                          color: notifire.textcolore)),
                                ),
                                const Spacer(),
                                Text('6 hrs',
                                    style:
                                        TextStyle(color: notifire.textcolore)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // isFirst: true,
                  beforeLineStyle: LineStyle(
                      color: Colors.grey.withOpacity(0.4), thickness: 2),
                  indicatorStyle: IndicatorStyle(
                      indicator: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(65)),
                        border: Border.all(color: Colors.pink, width: 4)),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commoncontain19({required double size}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image(
                      image: const AssetImage('assets/list.png'),
                      color: notifire.textcolore),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('Recent activities',
                      style: TextStyle(color: notifire.textcolore)),
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
              SizedBox(
                  height: 100,
                  width: Get.width,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: size < 1000 ? 0.25 : 0.1,
                    // isFirst: true,
                    startChild: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        '10:00',
                        style:
                            TextStyle(fontSize: 20, color: notifire.textcolore),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: notifire.bgcolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text('Meeting With',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: notifire.textcolore))),
                              const SizedBox(
                                width: 10,
                              ),
                              const Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/avatar-3 2c.png'),
                                    radius: 25,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/avatar-1 11.png'),
                                      radius: 25,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 80),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/avatar-5 2z.png'),
                                      radius: 25,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // isFirst: true,
                    beforeLineStyle: LineStyle(
                        color: Colors.grey.withOpacity(0.4), thickness: 2),
                    indicatorStyle: IndicatorStyle(
                        color: Colors.green,
                        indicator: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(65)),
                              border:
                                  Border.all(color: Colors.green, width: 4)),
                        )),
                  )),
              SizedBox(
                  height: 70,
                  width: Get.width,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: size < 1000 ? 0.25 : 0.1,
                    startChild: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('12:45',
                          style: TextStyle(
                              fontSize: 20, color: notifire.textcolore)),
                    ),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: notifire.bgcolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                'Port Lorem ipsum dolore sit amet, constrict advecting elite, sed do eipumes tempor,constriget adtipinge elite, sed do eipumes tempor,Lorem ipsum dolore sit amet,Consequte',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(color: notifire.textcolore),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    // isFirst: true,
                    beforeLineStyle: LineStyle(
                        color: Colors.grey.withOpacity(0.4), thickness: 2),
                    indicatorStyle: IndicatorStyle(
                        indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(65)),
                          border: Border.all(color: Colors.blue, width: 4)),
                    )),
                  )),
              SizedBox(
                  height: 70,
                  width: Get.width,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: size < 1000 ? 0.25 : 0.1,
                    startChild: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('14:00',
                          style: TextStyle(
                              fontSize: 20, color: notifire.textcolore)),
                    ),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: notifire.bgcolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                'Received a new feddback on GoFinance App product',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(color: notifire.textcolore),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    // isFirst: true,
                    beforeLineStyle: LineStyle(
                        color: Colors.grey.withOpacity(0.4), thickness: 2),
                    indicatorStyle: IndicatorStyle(
                        indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(65)),
                          border: Border.all(color: Colors.red, width: 4)),
                    )),
                  )),
              SizedBox(
                  height: 70,
                  width: Get.width,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: size < 1000 ? 0.25 : 0.1,
                    startChild: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('15:20',
                          style: TextStyle(
                              fontSize: 20, color: notifire.textcolore)),
                    ),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: notifire.bgcolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                'Lorem ipsum dolore sit amit, consecrate eiusmdd tempor incident ut labor et dolore magna,',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(color: notifire.textcolore),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    // isFirst: true,
                    beforeLineStyle: LineStyle(
                        color: Colors.grey.withOpacity(0.4), thickness: 2),
                    indicatorStyle: IndicatorStyle(
                        indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(65)),
                          border: Border.all(color: Colors.yellow, width: 4)),
                    )),
                  )),
              SizedBox(
                  height: 70,
                  width: Get.width,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: size < 1000 ? 0.25 : 0.1,
                    startChild: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('17:00',
                          style: TextStyle(
                              fontSize: 20, color: notifire.textcolore)),
                    ),
                    endChild: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: notifire.bgcolore,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                'Make Deposit USD 700 o ESL.',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(color: notifire.textcolore),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    // isFirst: true,
                    beforeLineStyle: LineStyle(
                        color: Colors.grey.withOpacity(0.4), thickness: 2),
                    indicatorStyle: IndicatorStyle(
                        indicator: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(65)),
                          border: Border.all(color: Colors.pink, width: 4)),
                    )),
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
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
              trailing: Padding(
                padding: const EdgeInsets.only(top: 20),
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

  TableRow _row() {
    return TableRow(children: [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar-1 11.png'),
          radius: 25,
        ),
        title: Text('Rhona Davidson',
            style: TextStyle(color: notifire.textcolore)),
        subtitle: Text('javascrpt Developer, Tokyo',
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text('Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Text('78%', style: TextStyle(color: notifire.textcolore))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE1F7E9),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.green))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _row1() {
    return TableRow(children: [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar-5 2z.png'),
          radius: 25,
        ),
        title: Text('Rhona Davidson',
            style: TextStyle(color: notifire.textcolore)),
        subtitle: Text('javascrpt Developer, Tokyo',
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text('Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Text('69%', style: TextStyle(color: notifire.textcolore))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.5),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE1F7E9),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.green))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _row2() {
    return TableRow(children: [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar-4 2m.png'),
          radius: 25,
        ),
        title: Text('Rhona Davidson',
            style: TextStyle(color: notifire.textcolore)),
        subtitle: Text('javascrpt Developer, Tokyo',
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text('Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Text('44%', style: TextStyle(color: notifire.textcolore))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.2),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE1F7E9),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.green))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _row3() {
    return TableRow(children: [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar-3 2c.png'),
          radius: 25,
        ),
        title: Text('Rhona Davidson',
            style: TextStyle(color: notifire.textcolore)),
        subtitle: Text('javascrpt Developer, Tokyo',
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text('Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Text('72%', style: TextStyle(color: notifire.textcolore))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE1F7E9),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.green))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow _row4() {
    return TableRow(children: [
      ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar-2 11.png'),
          radius: 25,
        ),
        title: Text('Rhona Davidson',
            style: TextStyle(color: notifire.textcolore)),
        subtitle: Text('javascrpt Developer, Tokyo',
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Text('Progress',
                      style: TextStyle(color: notifire.textcolore)),
                  const Expanded(
                      child: SizedBox(
                    width: 10,
                  )),
                  Text('45%', style: TextStyle(color: notifire.textcolore))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: const Color(0xffE1F7E9),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child:
                        Text('Follow', style: TextStyle(color: Colors.green))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      )
    ]);
  }

  TableRow secoundtable1() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Order ID', style: TextStyle(color: notifire.textcolore)),
      ),
      Text('Status', style: TextStyle(color: notifire.textcolore)),
      Text('Operator', style: TextStyle(color: notifire.textcolore)),
      Text('Location', style: TextStyle(color: notifire.textcolore)),
      Text('Progress', style: TextStyle(color: notifire.textcolore)),
      Text('Start date', style: TextStyle(color: notifire.textcolore)),
      Text('Estimation', style: TextStyle(color: notifire.textcolore)),
    ]);
  }

  TableRow secoundtable2() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text('837563', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(65)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Arrived', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
      const Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar-1 11.png'),
                radius: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-3 2c.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-2 11.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-4 2m.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 120),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-5 2z.png'),
                  radius: 20,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('Tokyo', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Row(
                children: [
                  Text('90%', style: TextStyle(color: notifire.textcolore)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('26/06/2023', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('27/06/2023', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow secoundtable3() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text('982365', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(65)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Pendinge', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
      const Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar-5 2z.png'),
                radius: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-4 2m.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-2 11.png'),
                  radius: 20,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            Text('Sun Francisco', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Row(
                children: [
                  Text('20%', style: TextStyle(color: notifire.textcolore)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('23/04/2023', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('28/04/2023', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow secoundtable4() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text('872048', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(65)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Movinge', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
      const Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar-2 11.png'),
                radius: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-4 2m.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-3 2c.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-5 2z.png'),
                  radius: 20,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('Edinburgh', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Row(
                children: [
                  Text('75%', style: TextStyle(color: notifire.textcolore)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('26/04/2023', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('30/04/2023', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow secoundtable5() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text('324712', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(65)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Hold', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
      const Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar-3 2c.png'),
                radius: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-5 2z.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-4 2m.png'),
                  radius: 20,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('Tokyo', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Row(
                children: [
                  Text('30%', style: TextStyle(color: notifire.textcolore)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('26/06/2023', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('30/06/2023', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow secoundtable6() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text('128747', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(65)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Movinge', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
      const Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar-4 2m.png'),
                radius: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-5 2z.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-3 2c.png'),
                  radius: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 90),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar-2 11.png'),
                  radius: 20,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('New York', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Row(
                children: [
                  Text('60%', style: TextStyle(color: notifire.textcolore)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.4),
                color: Colors.green,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('10/05/2023', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text('15/05/2023', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }
}
