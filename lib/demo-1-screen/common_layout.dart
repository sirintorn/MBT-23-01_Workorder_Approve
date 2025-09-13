// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_project1/Provider/apiservice.dart';
import '../Provider/colore_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class laout extends StatefulWidget {
  const laout({super.key});

  @override
  State<laout> createState() => _laoutState();
}

class _laoutState extends State<laout> {
  SampleItem? selectedMenu;
  List menu = [
    'Today',
    'Week',
    'Month',
    'Year',
  ];
  List menu11 = [
    'Today',
    'Week',
    'Month',
  ];

  int a = 0;
  int b = 0;

  List<ChartData> chartData = [
    ChartData(1, 35, 0),
    ChartData(2, 23, 0),
    ChartData(3, 34, 0),
    ChartData(4, 25, 0),
    ChartData(5, 40, 0)
  ];

  ColorNotifire notifire = ColorNotifire();

  List<dynamic> machines = [];
  List<dynamic> workOrderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    reloadEverySecond(10);
  }

  void loadData() async {
    machines = await APIService.getAllMachines();
    for (var item in machines) {
      var workOrders = await APIService.getMachineWorkOrder(item['id']);
      workOrderList.add(workOrders);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void reloadEverySecond(int s) {
    Future.delayed(Duration(seconds: s), () {
      if (mounted) {
        print('reloaded at ${DateTime.now().toString()}');
        loadData();
        reloadEverySecond(s);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Column(
      children: [
        // SizedBox(height: 20,),
        mainrow(),
        const SizedBox(
          height: 20,
        ),
        if (workOrderList.isEmpty == false)
          secoundcontain(size: MediaQuery.sizeOf(context).width),
        if (workOrderList.isEmpty == true)
          const SpinKitRotatingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  List isHover = [];
  List checkBox = [];
  int boxBorder = 0;

  Widget widgetWaiting(List<dynamic> workOrders) {
    late int count = 0;
    late int length = workOrders.length;
    if (length == 0) length = 1;
    for (var item in workOrders) {
      if (item['status'] == 1) count++;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
              // color: Color(0xffEBF0FE),
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Image(
                      image: AssetImage(
                          'assets/Symbol=Diamond, Component=Symbol.png')),
                  title: Text('Waiting',
                      style: TextStyle(color: notifire.textcolore)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      color: const Color(0xff6949FF),
                      value: count / length,
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(count.toString(),
                        style: const TextStyle(color: Color(0xff6949FF))),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget widgetApproved(List<dynamic> workOrders) {
    late int count = 0;
    late int length = workOrders.length;
    if (length == 0) length = 1;
    for (var item in workOrders) {
      if (item['status'] == 2) count++;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
              // color: Color(0xffEBF0FE),
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Image(
                      image:
                          AssetImage('assets/Symbol=XP, Component=Symbol.png')),
                  title: Text('Approved',
                      style: TextStyle(color: notifire.textcolore)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      color: const Color(0xff6949FF),
                      value: count / length,
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(count.toString(),
                        style: TextStyle(color: Color(0xff6949FF))),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget widgetInProgress(List<dynamic> workOrders) {
    late int count = 0;
    late int length = workOrders.length;
    if (length == 0) length = 1;
    for (var item in workOrders) {
      if (item['status'] == 3 || item['status'] == 4 || item['status'] == 5)
        count++;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
              // color: Color(0xffEBF0FE),
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Image(
                      image: AssetImage(
                          'assets/Symbol=Target, Component=Symbol.png')),
                  title: Text('In Progress',
                      style: TextStyle(color: notifire.textcolore),
                      overflow: TextOverflow.ellipsis),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      color: const Color(0xff6949FF),
                      value: count / length,
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(count.toString(),
                        style: TextStyle(color: Color(0xff6949FF))),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget widgetFinish(List<dynamic> workOrders) {
    late int count = 0;
    late int length = workOrders.length;
    if (length == 0) length = 1;
    for (var item in workOrders) {
      if (item['status'] == 6 || item['status'] == 7) count++;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
              // color: Color(0xffEBF0FE),
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Image(
                      image: AssetImage(
                          'assets/Symbol=Challenge, Component=Symbol.png')),
                  title: Text('Finish',
                      style: TextStyle(color: notifire.textcolore),
                      overflow: TextOverflow.ellipsis),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      color: const Color(0xff6949FF),
                      value: count / length,
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(count.toString(),
                        style: TextStyle(color: Color(0xff6949FF))),
                  ),
                )
              ],
            ),
          )),
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
                child: Text('Dashboard',
                    style: TextStyle(
                        fontFamily: 'Jost-SemiBold',
                        fontSize: 20,
                        color: notifire.textcolore,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget secoundcontain({required double size}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          // height: 480,
          decoration: BoxDecoration(
            color: notifire.containcolore1,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Text('Machine Progress',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: notifire.textcolore)),
              ),
              SingleChildScrollView(
                //scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  width: size < 1000 ? 1000 : size,
                  decoration: BoxDecoration(
                    color: notifire.containcolore1,
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Table(
                    // border: TableBorder.all(color: Colors.black),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(250),
                      0: FixedColumnWidth(250),
                      2: FixedColumnWidth(250),
                      3: FixedColumnWidth(250),
                      4: FixedColumnWidth(0),
                    },
                    children: machineProgressBuilder(),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  List<TableRow> machineProgressBuilder() {
    List<TableRow> wids = [];
    for (int i = 0; i < machines.length; i++) {
      wids.add(_row(machines[i]));
      wids.add(_rowData(machines[i], workOrderList[i]));
    }
    return wids;
  }

  TableRow _row(dynamic machine) {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/smart_watch.png'))),
        ),
        title: Text(machine['name'],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        // child: Text('\$38,536',style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        // child: Text('Reactjs,HTML',style: TextStyle(color: notifire.textcolore)),
      ),
      const SizedBox(),
      const SizedBox()
      /*Padding(
          padding: const EdgeInsets.only(top: 20, right: 10),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey.withOpacity(0.4),
            color: Colors.purple,
            value: 0.8,
          ),
        ),*/
      /*Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text('80%', style: TextStyle(color: notifire.textcolore)),
        ),*/
    ]);
  }

  TableRow _rowData(dynamic machine, List<dynamic> workOrders) {
    return TableRow(children: [
      widgetWaiting(workOrders),
      widgetApproved(workOrders),
      widgetInProgress(workOrders),
      widgetFinish(workOrders),
      const SizedBox()
    ]);
  }

  TableRow _rew() {
    return TableRow(children: [
      ListTile(
        title: Text('SELLER NAME',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('COMPANY', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('PRODUCT', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('REVENUE', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('STATUS', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _rew1() {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/avatar-1 11.png'))),
        ),
        title: Text('Gluttakh Biblical',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Samsung',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Smart Phone',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('\$38,536',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Done',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _rew2() {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/avatar-5 2z.png'))),
        ),
        title: Text('Celtic johan',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Aus',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Laptop',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('\$20,573',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Done',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _rew3() {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/avatar-4 2m.png'))),
        ),
        title: Text('Basque Belarusian',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Google',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Watch',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('\$17,457',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Pendinge',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _rew4() {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/robert-4.png'))),
        ),
        title: Text('Tsang Xalaxxi',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Apple',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Computer',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('\$15,354',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Done',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _rew5() {
    return TableRow(children: [
      ListTile(
        leading: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF2EAFB),
              image: const DecorationImage(
                  image: AssetImage('assets/avatar-1 11.png'))),
        ),
        title: Text('Finnish French',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Panasonic',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Sunglass',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('\$12,354',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Done',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _ruw() {
    return const TableRow(children: [
      ListTile(
        title: Text('BROWSERS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: Colors.grey)),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text('SESSION', style: TextStyle(color: Colors.grey)),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text('BOUNCE RATE', style: TextStyle(color: Colors.grey)),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text('CET', style: TextStyle(color: Colors.grey)),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text('GOAL CONV.RATE', style: TextStyle(color: Colors.grey)),
      ),
    ]);
  }

  TableRow _ruw1() {
    return TableRow(children: [
      ListTile(
        title: Text('Google Chrome',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('92,345', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('3.5%', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('12025', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('90%', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _ruw2() {
    return TableRow(children: [
      ListTile(
        title: Text('Mozila Firefox',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('92,345', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('3.5%', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('12025', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('90%', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _ruw3() {
    return TableRow(children: [
      ListTile(
        title: Text('Apple Safari',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('92,345', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('3.5%', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('12025', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('90%', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _ruw4() {
    return TableRow(children: [
      ListTile(
        title: Text('Internet Explorer',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('92,345', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('3.5%', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('12025', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('90%', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  TableRow _ruw5() {
    return TableRow(children: [
      ListTile(
        title: Text('Opera Mini',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('92,345', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('3.5%', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('12025', style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('90%', style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  Widget somecontain(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String img1,
      required String img2,
      required Color colore1,
      required Color colore2}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          height: 170,
          width: 400,
          decoration: BoxDecoration(
              color: notifire.containcolore1,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: ListTile(
                  title: Text(txt1,
                      style: TextStyle(
                          fontSize: 30,
                          color: notifire.textcolore,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                  subtitle: Text(txt2,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                      overflow: TextOverflow.ellipsis),
                  trailing: Container(
                    height: 90,
                    width: 60,
                    decoration: BoxDecoration(
                        color: colore1,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Image(
                      image: AssetImage(img1),
                      color: colore2,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Container(
                  height: 40,
                  // width: 500,
                  decoration: BoxDecoration(
                      color: notifire.getsecoundcontain,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Image(
                        image: AssetImage(img2),
                        color: Colors.green,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(txt3,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 15),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(txt4,
                          style: TextStyle(
                              color: notifire.textcolore, fontSize: 13),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget SalesLocation(
      {required String txt1,
      required String txt2,
      required String txt3,
      Color? colo,
      required String txt4}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(4.5),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          Text(txt1,
              style: TextStyle(color: colo), overflow: TextOverflow.ellipsis),
          Text(txt2,
              style: TextStyle(color: colo), overflow: TextOverflow.ellipsis),
          Text(txt3,
              style: TextStyle(color: colo), overflow: TextOverflow.ellipsis),
          Text(txt4,
              style: TextStyle(color: colo), overflow: TextOverflow.ellipsis),
        ]),
      ],
    );
  }

  Widget MemberProgress(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String img,
      required Color color,
      required Color backgrounde,
      required double vle}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(6),
        1: FlexColumnWidth(6),
        2: FlexColumnWidth(6),
        3: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img))),
            ),
            title:
                Text(txt1, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(txt2),
          Text(txt3),
          LinearProgressIndicator(
            backgroundColor: backgrounde,
            color: color,
            value: vle,
          ),
          Text(txt4)
        ]),
      ],
    );
  }

  Widget MemberProgress2(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      required String img}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(6),
        1: FlexColumnWidth(6),
        2: FlexColumnWidth(6),
        3: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img))),
            ),
            title:
                Text(txt1, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(txt2),
          Text(txt3),
          Text(txt4),
          Text(txt5),
        ]),
      ],
    );
  }

  TableRow MemberProgress3(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String img}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(right: 40, top: 20, bottom: 10),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 10),
        child: Text(txt1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 10),
        child: Text(txt2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 10),
        child: Text(txt3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 10),
        child: Text(txt4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: notifire.textcolore)),
      ),
    ]);
  }

  Widget MemberProgress4(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      Color? clore}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          Text(txt1,
              style: TextStyle(overflow: TextOverflow.ellipsis, color: clore)),
          Text(txt2,
              style: TextStyle(overflow: TextOverflow.ellipsis, color: clore)),
          Text(txt3,
              style: TextStyle(overflow: TextOverflow.ellipsis, color: clore)),
          Text(txt4,
              style: TextStyle(overflow: TextOverflow.ellipsis, color: clore)),
          Text(txt5,
              style: TextStyle(overflow: TextOverflow.ellipsis, color: clore)),
        ]),
      ],
    );
  }

  Widget MemberProgressdemo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String img,
      required Color color,
      required Color backgrounde,
      required double vle}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(6),
        1: FlexColumnWidth(6),
        2: FlexColumnWidth(6),
        3: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img))),
            ),
            title: Text(txt1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: notifire.textcolore)),
          ),
          Text(txt2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          LinearProgressIndicator(
            backgroundColor: backgrounde,
            color: color,
            value: vle,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(txt4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore))
        ]),
      ],
    );
  }

  Widget MemberProgressdemo1(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String img,
      required Color color,
      required Color backgrounde,
      required double vle,
      required String txt5,
      required String txt6}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2.3),
        3: FlexColumnWidth(2.3),
        4: FlexColumnWidth(2.3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img))),
            ),
            title: Text(txt1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis)),
          ),
          Text(txt2, overflow: TextOverflow.ellipsis),
          Text(txt3, overflow: TextOverflow.ellipsis),
          Text(txt5, overflow: TextOverflow.ellipsis),
          Text(txt6, overflow: TextOverflow.ellipsis),
          LinearProgressIndicator(
            backgroundColor: backgrounde,
            color: color,
            value: vle,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(txt4, overflow: TextOverflow.ellipsis)
        ]),
      ],
    );
  }

  Widget MemberProgress2demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      String? img}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img!))),
            ),
            title: Text(txt1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: notifire.textcolore)),
          ),
          Text(txt2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
        ]),
      ],
    );
  }

  Widget MemberProgress22demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      String? img,
      required String txt6}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffF2EAFB),
                  image: DecorationImage(image: AssetImage(img!))),
            ),
            title: Text(txt1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis)),
          ),
          Text(txt2, overflow: TextOverflow.ellipsis),
          Text(txt3, overflow: TextOverflow.ellipsis),
          Text(txt4, overflow: TextOverflow.ellipsis),
          Text(txt5, overflow: TextOverflow.ellipsis),
          Text(txt6, overflow: TextOverflow.ellipsis),
        ]),
      ],
    );
  }

  Widget MemberProgress33demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      required String txt6}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            title: Text(txt1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis)),
          ),
          Text(txt2, overflow: TextOverflow.ellipsis),
          Text(txt3, overflow: TextOverflow.ellipsis),
          Text(txt4, overflow: TextOverflow.ellipsis),
          Text(txt5, overflow: TextOverflow.ellipsis),
          Text(txt6, overflow: TextOverflow.ellipsis),
        ]),
      ],
    );
  }

  Widget MemberProgress3demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt5,
      String? txt4}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            title: Text(txt1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: notifire.textcolore)),
          ),
          Text(txt2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt4!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
        ]),
      ],
    );
  }

  Widget MemberProgress4demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt5,
      String? txt4}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(3.3),
        2: FlexColumnWidth(2.7),
        3: FlexColumnWidth(2.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            title: Text(txt1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: notifire.textcolore)),
          ),
          Text(txt2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt4!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
          Text(txt5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: notifire.textcolore)),
        ]),
      ],
    );
  }

  Widget MemberProgress44demo(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required String txt5,
      required String txt6,
      required String txt7}) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2.8),
        1: FlexColumnWidth(2.7),
        2: FlexColumnWidth(1.9),
        3: FlexColumnWidth(2.2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(1.8),
        // 6: FlexColumnWidth(0.2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          ListTile(
            title: Text(txt1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis)),
          ),
          Text(txt2, overflow: TextOverflow.ellipsis),
          Text(txt3, overflow: TextOverflow.ellipsis),
          Text(txt4, overflow: TextOverflow.ellipsis),
          Text(txt5, overflow: TextOverflow.ellipsis),
          Text(txt6, overflow: TextOverflow.ellipsis),
          Text(txt7, overflow: TextOverflow.ellipsis),
        ]),
      ],
    );
  }

  TableRow MemberProgress5demoi(
      {required String txt1,
      required String txt2,
      required String txt3,
      required String txt4,
      required Color clor}) {
    return TableRow(children: [
      Text(txt1,
          overflow: TextOverflow.ellipsis, style: TextStyle(color: clor)),
      Text(txt2,
          overflow: TextOverflow.ellipsis, style: TextStyle(color: clor)),
      Text(txt3,
          overflow: TextOverflow.ellipsis, style: TextStyle(color: clor)),
      Text(txt4,
          overflow: TextOverflow.ellipsis, style: TextStyle(color: clor)),
      Text(txt4,
          overflow: TextOverflow.ellipsis, style: TextStyle(color: clor)),
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}
