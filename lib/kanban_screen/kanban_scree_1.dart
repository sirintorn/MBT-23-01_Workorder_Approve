// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:convert';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:provider/provider.dart';
import 'package:web_project1/Provider/apiservice.dart';
import 'package:web_project1/Provider/userlogin.dart';
import 'package:web_project1/kanban_screen/kanban_workorder_board.dart';
import '../Provider/colore_provider.dart';

class kanban_screen_1 extends StatefulWidget {
  const kanban_screen_1({super.key});

  @override
  State<kanban_screen_1> createState() => _kanban_screen_1State();
}

class _kanban_screen_1State extends State<kanban_screen_1> {
  var group1 = AppFlowyGroupData(id: "waiting", name: "Waiting", items: []);
  var group2 = AppFlowyGroupData(
    id: "approved",
    name: "Approved",
    items: []
  );
  var group3 = AppFlowyGroupData(
      id: "inProgress",
      name: "In Progress",
      items: <AppFlowyGroupItem>[]);
  var group4 = AppFlowyGroupData(
      id: "finished",
      name: "Finished",
      items: <AppFlowyGroupItem>[]);

  AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    //onMoveGroupItem: onLogicalChange(groupId, fromIndex, toIndex),
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      //CODE THIS TO WORK
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  final AppFlowyBoardController controller2 = AppFlowyBoardController();
  final AppFlowyBoardController controller3 = AppFlowyBoardController();

  late AppFlowyBoardScrollController boardController;

  late List<dynamic> kanbanItems;
  late List<dynamic> machines;

  late dynamic user;

  AppFlowyGroupItem generateCard(dynamic item) {
    int mId = item['machineId'];
    var machine;
    for (var m in machines) {
      if (m['id'] == mId) {
        machine = m;
      }
    }
    return RichTextItem(
      prqId: "${item['prqId']}",
      machineName: '${machine['name']}',
      deliveryDate: '${item['prdCompletionDeadline']}',
      specCoil: '${item['project']}',
      totalLength: '${item['ipo']}',
      codeCoil: '${item['id'].toString()}',
    );
  }

  void onLogicalChange(fromGroupId, fromIndex, toGroupId, toIndex) async {
    debugPrint(toGroupId);
    debugPrint(group1.items.length.toString());
    debugPrint(group2.items.length.toString());

    if (toGroupId == 'approved') {
      // status = 2
      var item = group2.items[toIndex];

      var itemId = int.tryParse(item.id);
      var modifiedBy = user['id'];
      var statusCode = 2;
      debugPrint('wId:$itemId stId:$modifiedBy status:$statusCode');
      try {
        await APIService.updateWorkorderStatus(itemId!, modifiedBy, statusCode);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else if (toGroupId == 'waiting') {
      //status = 1
      var item = group1.items[toIndex];

      var itemId = int.tryParse(item.id);
      var modifiedBy = user['id'];
      var statusCode = 2;
      debugPrint('wId:$itemId stId:$modifiedBy status:$statusCode');

      try {
        await APIService.updateWorkorderStatus(itemId!, modifiedBy, statusCode);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('NONE ABOVE');
    }
  }

  void loadKanban() async {
    try {
      user = await UserLoginProvider().getUser();
      debugPrint(user['id'].toString());
      machines = await APIService.getAllMachines();

      var g1 = <AppFlowyGroupItem>[];
      var g2 = <AppFlowyGroupItem>[];
      var g345 = <AppFlowyGroupItem>[];
      var g67 = <AppFlowyGroupItem>[];

      kanbanItems = await APIService.getWorkordersKanban();
      for (var item in kanbanItems) {
        switch (item['status']) {
          case 1:
            g1.add(generateCard(item));
            break;
          case 2:
            g2.add(generateCard(item));
            break;
          case 3:
          case 4:
          case 5:
            g345.add(generateCard(item));
            break;
          case 6:
          case 7:
            g67.add(generateCard(item));
            break;
        }
      }

      group1 = AppFlowyGroupData(id: "waiting", name: "Waiting", items: g1);
      group2 = AppFlowyGroupData(
        id: "approved",
        name: "Approved",
        items: g2,
      );
      group3 =
          AppFlowyGroupData(id: "inProgress", name: "In Progress", items: g345);
      group4 =
          AppFlowyGroupData(id: "finished", name: "Finished", items: g67);

      controller.addGroup(group1);
      controller.addGroup(group2);
      controller2.addGroup(group3);
      controller3.addGroup(group4);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    loadKanban();
    boardController = AppFlowyBoardScrollController();
    controller = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move item from $fromIndex to $toIndex');
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        //CODE THIS TO WORK
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        onLogicalChange(fromGroupId, fromIndex, toGroupId, toIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#5499eb'),
      stretchGroupHeight: false,
    );
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, // Align items at the ends of the row
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items vertically centered

          children: [
            AppFlowyBoard(
                controller: controller,
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),
                    child: _buildCard(groupItem),
                  );
                },
                boardScrollController: boardController,
                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    icon: const Icon(Icons.lightbulb_circle),
                    title: SizedBox(
                        width: 80,
                        child: Text(columnData.headerData.groupName)),
                    // addIcon: const Icon(Icons.add, size: 20),
                    // moreIcon: const Icon(Icons.more_horiz, size: 20),
                    height: 50,
                    margin: config.groupBodyPadding,
                  );
                },
                groupConstraints: const BoxConstraints.tightFor(width: 320),
                config: config),
            AppFlowyBoard(
                controller: controller2,
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),
                    child: _buildCard2(groupItem),
                  );
                },
                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    icon: const Icon(Icons.lightbulb_circle),
                    title: SizedBox(
                        width: 85,
                        child: Text(columnData.headerData.groupName)),
                    // addIcon: const Icon(Icons.add, size: 20),
                    // moreIcon: const Icon(Icons.more_horiz, size: 20),
                    height: 50,
                    margin: config.groupBodyPadding,
                  );
                },
                groupConstraints: const BoxConstraints.tightFor(width: 320),
                config: config),
            AppFlowyBoard(
                controller: controller3,
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),
                    child: _buildCard2(groupItem),
                  );
                },
                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    icon: const Icon(Icons.lightbulb_circle),
                    title: SizedBox(
                        width: 85,
                        child: Text(columnData.headerData.groupName)),
                    addIcon: const Icon(Icons.add, size: 20),
                    moreIcon: const Icon(Icons.more_horiz, size: 20),
                    height: 50,
                    margin: config.groupBodyPadding,
                  );
                },
                groupConstraints: const BoxConstraints.tightFor(width: 320),
                config: config),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(AppFlowyGroupItem item) {
  if (item is TextItem) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Text(item.s),
      ),
    );
  }

  if (item is RichTextItem) {
    return RichTextCard(item: item);
  }

  throw UnimplementedError();
}

Widget _buildCard2(AppFlowyGroupItem item) {
  if (item is TextItem) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Text(item.s),
      ),
    );
  }

  if (item is RichTextItem) {
    return NormalTextCard(item: item);
  }

  throw UnimplementedError();
}

class RichTextCard extends StatefulWidget {
  final RichTextItem item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.item.machineName} ${widget.item.prqId}",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.deliveryDate,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              widget.item.codeCoil,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            TextButton(onPressed: () {}, child: Text('View info')),
            TextButton(onPressed: () {}, child: Text('Delete'))
          ],
        ),
      ),
    );
  }
}

class NormalTextCard extends StatefulWidget {
  final RichTextItem item;
  const NormalTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<NormalTextCard> createState() => _NormalTextCardState();
}

class _NormalTextCardState extends State<NormalTextCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.item.machineName} - ${widget.item.prqId}",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.deliveryDate,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            Text(
              widget.item.codeCoil,
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            TextButton(onPressed: () {}, child: Text('View info')),
          ],
        ),
      ),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String machineName;
  final String prqId;
  final String deliveryDate;
  final String specCoil;
  final String codeCoil;
  final String totalLength;

  RichTextItem(
      {required this.machineName,
      required this.prqId,
      required this.deliveryDate,
      required this.specCoil,
      required this.codeCoil,
      required this.totalLength});

  @override
  String get id => codeCoil;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
