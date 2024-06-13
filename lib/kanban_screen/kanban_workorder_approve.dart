import 'package:flutter/material.dart';

import 'package:appflowy_board/appflowy_board.dart';

class WorkOrderApprove extends StatefulWidget {
  const WorkOrderApprove({Key? key}) : super(key: key);

  @override
  State<WorkOrderApprove> createState() => _MultiBoardListExampleState();
}

class _MultiBoardListExampleState extends State<WorkOrderApprove> {

  late List<AppFlowyGroupItem> waitingItem ;

  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  final AppFlowyBoardController controller2 = AppFlowyBoardController();

  final AppFlowyBoardController controller3 = AppFlowyBoardController();

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
    final group1 = AppFlowyGroupData(id: "waiting", name: "Waiting", items: [
      TextItem("Card 1"),
      TextItem("Card 2"),
      RichTextItem(
        prqId: "Card 3",
        machineName: '',
        deliveryDate: 'Aug 1, 2020 4:05 PM',
        specCoil: 'Sirintorn',
        totalLength: ' ',
        codeCoil: ' ',
      ),
      TextItem("Card 4"),
      TextItem("Card 5"),
    ]);

    final group2 = AppFlowyGroupData(
      id: "approved",
      name: "Approved",
      items: <AppFlowyGroupItem>[
        TextItem("Card 6"),
        RichTextItem(
          prqId: "Card 3",
          machineName: '',
          deliveryDate: 'Aug 1, 2020 4:05 PM',
          specCoil: 'Sirintorn',
          totalLength: ' ',
          codeCoil: ' ',
        ),
        RichTextItem(
          prqId: "Card 3",
          machineName: '',
          deliveryDate: 'Aug 1, 2020 4:05 PM',
          specCoil: 'Sirintorn',
          totalLength: ' ',
          codeCoil: ' ',
        ),
      ],
    );

    final group3 = AppFlowyGroupData(
        id: "inProgress",
        name: "In Progress",
        items: <AppFlowyGroupItem>[
          TextItem("Card 9"),
          RichTextItem(
            prqId: "Card 3",
            machineName: '',
            deliveryDate: 'Aug 1, 2020 4:05 PM',
            specCoil: 'Sirintorn',
            totalLength: ' ',
            codeCoil: ' ',
          ),
          TextItem("Card 11"),
          TextItem("Card 12"),
        ]);
    final group4 = AppFlowyGroupData(
        id: "finished",
        name: "Finished",
        items: <AppFlowyGroupItem>[
          TextItem("Card 13"),
          TextItem("Card 14"),
          TextItem("Card 15"),
        ]);


    controller.addGroup(group1);
    controller.addGroup(group2);
    controller2.addGroup(group3);
    controller3.addGroup(group4);
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#5499eb'),
      stretchGroupHeight: false,
    );
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align items at the ends of the row
            crossAxisAlignment: CrossAxisAlignment.start, // Align items vertically centered

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
                          child: Text(columnData.headerData.groupName)
                      ),
                      // addIcon: const Icon(Icons.add, size: 20),
                      // moreIcon: const Icon(Icons.more_horiz, size: 20),
                      height: 50,
                      margin: config.groupBodyPadding,
                    );
                  },
                  groupConstraints: const BoxConstraints.tightFor(width: 240),
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
                          child: Text(columnData.headerData.groupName)
                      ),
                      addIcon: const Icon(Icons.add, size: 20),
                      moreIcon: const Icon(Icons.more_horiz, size: 20),
                      height: 50,
                      margin: config.groupBodyPadding,
                    );
                  },
                  groupConstraints: const BoxConstraints.tightFor(width: 240),
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
                          child: Text(columnData.headerData.groupName)
                      ),
                      addIcon: const Icon(Icons.add, size: 20),
                      moreIcon: const Icon(Icons.more_horiz, size: 20),
                      height: 50,
                      margin: config.groupBodyPadding,
                    );
                  },
                  groupConstraints: const BoxConstraints.tightFor(width: 240),
                  config: config),
            ],
          ),
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
              widget.item.prqId,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.deliveryDate,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.codeCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
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
              widget.item.prqId,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.item.deliveryDate,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.codeCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              widget.item.specCoil,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
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
  String get id => prqId;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
