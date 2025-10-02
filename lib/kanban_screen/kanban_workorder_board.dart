import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:appflowy_board/appflowy_board.dart';
import '../Provider/colore_provider.dart';
import '../Provider/apiservice.dart';

class WorkOrderApprove1 extends StatefulWidget {
  const WorkOrderApprove1({Key? key}) : super(key: key);

  @override
  State<WorkOrderApprove1> createState() => _MultiBoardListExampleState();
}

class _MultiBoardListExampleState extends State<WorkOrderApprove1> {
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

  Future<void> _showWorkorderInfo(BuildContext context) async {
    final ColorNotifire notifire = Provider.of<ColorNotifire>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final workorderId = int.parse(widget.item.codeCoil);

      final workorderDetails = await APIService.getWorkorderDetails(workorderId);
      final workorderMaterials = await APIService.getWorkorderMaterials(workorderId);
      final workorderFG = await APIService.getWorkorderFG(workorderId);

      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: notifire.containcolore1,
            title: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  'Work Order Information',
                  style: TextStyle(color: notifire.textcolore),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWorkorderSection(workorderDetails, notifire),
                    const SizedBox(height: 20),
                    _buildMaterialsSection(workorderMaterials, notifire),
                    const SizedBox(height: 20),
                    _buildFGSection(workorderFG, notifire),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading work order information: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildWorkorderSection(dynamic workorder, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Order Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (workorder != null) ...[
              _buildInfoRow('Work Order ID', workorder['woId']?.toString() ?? 'N/A', notifire),
              _buildInfoRow('PRQ ID', workorder['prqId']?.toString() ?? 'N/A', notifire),
              _buildInfoRow('Project', workorder['project']?.toString() ?? 'N/A', notifire),
              _buildInfoRow('Completion Deadline', workorder['prdCompletionDeadline']?.toString() ?? 'N/A', notifire),
              _buildInfoRow('Status', _getStatusText(workorder['status']), notifire),
              _buildInfoRow('IPO', workorder['ipo']?.toString() ?? 'N/A', notifire),
              _buildInfoRow('Labor Qty', workorder['laborQty']?.toString() ?? 'N/A', notifire),
            ] else
              Text('No work order details available', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialsSection(dynamic materials, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Materials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (materials != null && materials is List && materials.isNotEmpty) ...[
              ...materials.map((material) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Spec Coil Code', material['specoilCode']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Description', material['specoilDescription']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Coil No', material['coilNo']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Weight Start', material['coilWeightStart']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Weight Actual', material['coilWeightActual']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Weight Remaining', material['coilWeightRemaining']?.toString() ?? 'N/A', notifire),
                    ],
                  ),
                ),
              )).toList(),
            ] else
              Text('No materials found', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildFGSection(dynamic finishedGoods, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Finished Goods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (finishedGoods != null && finishedGoods is List && finishedGoods.isNotEmpty) ...[
              ...finishedGoods.map((fg) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('FG Spec', fg['fgSpec']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Description', fg['fgDescription']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Length', fg['fgLenght']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Quantity', fg['fgQty']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Weight Estimate', fg['fgWeightEstimate']?.toString() ?? 'N/A', notifire),
                      _buildInfoRow('Area', fg['fgArea']?.toString() ?? 'N/A', notifire),
                    ],
                  ),
                ),
              )).toList(),
            ] else
              Text('No finished goods found', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ColorNotifire notifire) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: notifire.textcolore),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(dynamic status) {
    switch (status) {
      case 1:
        return 'Waiting';
      case 2:
        return 'Approved';
      case 3:
        return 'In Progress';
      case 4:
        return 'Finished';
      default:
        return 'Unknown ($status)';
    }
  }

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
            TextButton(
              onPressed: () => _showWorkorderInfo(context),
              child: const Text('View info'),
            ),
            TextButton(onPressed: () {}, child: const Text('Delete'))
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

  Future<void> _showWorkorderInfoNormal(BuildContext context) async {
    final ColorNotifire notifire = Provider.of<ColorNotifire>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final workorderId = int.parse(widget.item.codeCoil);

      final workorderDetails = await APIService.getWorkorderDetails(workorderId);
      final workorderMaterials = await APIService.getWorkorderMaterials(workorderId);
      final workorderFG = await APIService.getWorkorderFG(workorderId);

      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: notifire.containcolore1,
            title: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  'Work Order Information',
                  style: TextStyle(color: notifire.textcolore),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWorkorderSectionNormal(workorderDetails, notifire),
                    const SizedBox(height: 20),
                    _buildMaterialsSectionNormal(workorderMaterials, notifire),
                    const SizedBox(height: 20),
                    _buildFGSectionNormal(workorderFG, notifire),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading work order information: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildWorkorderSectionNormal(dynamic workorder, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Order Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (workorder != null) ...[
              _buildInfoRowNormal('Work Order ID', workorder['woId']?.toString() ?? 'N/A', notifire),
              _buildInfoRowNormal('PRQ ID', workorder['prqId']?.toString() ?? 'N/A', notifire),
              _buildInfoRowNormal('Project', workorder['project']?.toString() ?? 'N/A', notifire),
              _buildInfoRowNormal('Completion Deadline', workorder['prdCompletionDeadline']?.toString() ?? 'N/A', notifire),
              _buildInfoRowNormal('Status', _getStatusTextNormal(workorder['status']), notifire),
              _buildInfoRowNormal('IPO', workorder['ipo']?.toString() ?? 'N/A', notifire),
              _buildInfoRowNormal('Labor Qty', workorder['laborQty']?.toString() ?? 'N/A', notifire),
            ] else
              Text('No work order details available', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialsSectionNormal(dynamic materials, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Materials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (materials != null && materials is List && materials.isNotEmpty) ...[
              ...materials.map((material) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRowNormal('Spec Coil Code', material['specoilCode']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Description', material['specoilDescription']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Coil No', material['coilNo']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Weight Start', material['coilWeightStart']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Weight Actual', material['coilWeightActual']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Weight Remaining', material['coilWeightRemaining']?.toString() ?? 'N/A', notifire),
                    ],
                  ),
                ),
              )).toList(),
            ] else
              Text('No materials found', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildFGSectionNormal(dynamic finishedGoods, ColorNotifire notifire) {
    return Card(
      color: notifire.containcolore1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Finished Goods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),
            if (finishedGoods != null && finishedGoods is List && finishedGoods.isNotEmpty) ...[
              ...finishedGoods.map((fg) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRowNormal('FG Spec', fg['fgSpec']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Description', fg['fgDescription']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Length', fg['fgLenght']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Quantity', fg['fgQty']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Weight Estimate', fg['fgWeightEstimate']?.toString() ?? 'N/A', notifire),
                      _buildInfoRowNormal('Area', fg['fgArea']?.toString() ?? 'N/A', notifire),
                    ],
                  ),
                ),
              )).toList(),
            ] else
              Text('No finished goods found', style: TextStyle(color: notifire.textcolore)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowNormal(String label, String value, ColorNotifire notifire) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: notifire.textcolore),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusTextNormal(dynamic status) {
    switch (status) {
      case 1:
        return 'Waiting';
      case 2:
        return 'Approved';
      case 3:
        return 'In Progress';
      case 4:
        return 'Finished';
      default:
        return 'Unknown ($status)';
    }
  }

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
            TextButton(
              onPressed: () => _showWorkorderInfoNormal(context),
              child: const Text('View info'),
            ),
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
