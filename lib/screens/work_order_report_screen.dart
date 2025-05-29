import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import '../DataModel/workorder.dart';
import '../DataModel/workorder_material.dart';
import '../DataModel/workorder_fg.dart';
import '../DataModel/machine.dart';
import '../services/work_order_service.dart';

class WorkOrderReportScreen extends StatefulWidget {
  final String workOrderId;

  const WorkOrderReportScreen({
    Key? key,
    required this.workOrderId,
  }) : super(key: key);

  @override
  State<WorkOrderReportScreen> createState() => _WorkOrderReportScreenState();
}

class _WorkOrderReportScreenState extends State<WorkOrderReportScreen> {
  // Use the production API base URL
  final WorkOrderService _service =
      WorkOrderService(baseUrl: 'http://metalbuildingthai-app.com:8080');
  bool _isLoading = true;
  String? _error;
  String? _debugInfo;
  int _retryCount = 0;

  WorkorderModel? _workOrder;
  List<WorkorderMaterialModel> _materials = [];
  List<WorkorderFGModel> _finishedGoods = [];
  MachineModel? _machine;

  @override
  void initState() {
    super.initState();
    _loadWorkOrderData();
  }

  Future<void> _loadWorkOrderData() async {
    try {
      developer.log(
          'Loading work order data for ID: ${widget.workOrderId}, attempt: ${_retryCount + 1}');

      setState(() {
        _isLoading = true;
        _error = null;
        _debugInfo = null;
      });

      // Try to get raw data first for debugging
      if (_retryCount > 0) {
        final rawData = await _service.getRawData(
            'MBTService/api/getWorkOrderSingle', widget.workOrderId);
        setState(() {
          _debugInfo = 'Raw API Response: $rawData';
        });
        developer.log('Raw API response: $rawData');
      }

      // Use the API endpoint with the provided workOrderId
      final reportData = await _service.getWorkOrderReport(widget.workOrderId);

      setState(() {
        _workOrder = reportData['workOrder'] as WorkorderModel;
        _materials = reportData['materials'] as List<WorkorderMaterialModel>;
        _finishedGoods = reportData['finishedGoods'] as List<WorkorderFGModel>;

        // Safely handle the machine data
        _machine = null; // Reset first
        final machineData = reportData['machineData'];
        if (machineData != null && machineData is Map<String, dynamic>) {
          _machine = MachineModel(
            id: machineData['id'],
            name: machineData['name'],
            description: machineData['description'],
          );
        }

        _isLoading = false;
        _retryCount = 0; // Reset on success
      });
    } catch (e) {
      developer.log('Error loading work order data: $e', error: e);

      setState(() {
        _error = e.toString();
        _isLoading = false;
        _retryCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Order'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading work order data...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading data',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                _error!,
                textAlign: TextAlign.center,
              ),
            ),
            if (_debugInfo != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _debugInfo!,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWorkOrderData,
              child: const Text('Retry'),
            ),
            if (_retryCount > 1)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Troubleshooting Tips'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('1. Check if the work order ID is correct'),
                              Text(
                                  '2. Verify that the API server is accessible'),
                              Text('3. Check your internet connection'),
                              Text('4. Verify API endpoint URLs'),
                              Text('5. Contact support if problem persists'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Show Troubleshooting Tips'),
                ),
              ),
          ],
        ),
      );
    }

    if (_workOrder == null) {
      return const Center(
        child: Text('No work order data found'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWorkOrder(),
            const SizedBox(height: 24),
            _buildMaterialsSection(),
            const SizedBox(height: 24),
            _buildFinishedGoodsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkOrder() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Order',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Work Order ID:,${_workOrder?.woId}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Date:${_workOrder?.woDate}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project:,${_workOrder!.project}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'IPO:${_workOrder?.ipo}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PRQ ID:,${_workOrder?.prqId}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'PRD Completion Deadline:${_workOrder?.prdCompletionDeadline}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   'Machine:,${_machine?.name}',
                //   style: Theme.of(context).textTheme.headline6,
                // ),
                Text(
                  'Labor Quantity:${_workOrder?.laborQty?.toString() ?? '0'} ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Setup Time:${_workOrder!.setuptime?.toString() ?? '0'} min',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Downtime:${_workOrder?.downtime?.toString() ?? '0'} min',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Text(
                //   'Status:${_workOrder?.status}',
                //   style: Theme.of(context).textTheme.subtitle2,
                // ),
              ],
            ),
            _buildDetailRow('Status', _getStatusText(_workOrder?.status)),
          ],
        ),
      ),
    );
  }

  String? _getStatusText(int? status) {
    if (status == null) return null;

    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Waiting';
      case 2:
        return 'Approved';
      case 3:
        return 'Coil Prepared';
      case 4:
        return 'in Process';
      case 5:
        return 'Pause';
      case 6:
        return 'Finished';
      case 7:
        return 'Archived';
      default:
        return 'Unknown Status ($status)';
    }
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Work Order Input',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Materials: ${_materials.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_materials.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No materials found'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _materials.length,
                itemBuilder: (context, index) {
                  final material = _materials[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            material.specoilDescription ?? 'Unknown Material',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (material.remark != null &&
                              material.remark!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Remark: ${material.remark}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Barcode: ${material.specoilBarcode ?? ' '}'),
                                    Text(
                                        'Code: ${material.specoilCode ?? ' '}'),
                                    Text('Lot: ${material.lot ?? ' '}'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Coil No: ${material.coilNo ?? ' '}'),
                                    Text(
                                        'Weight: ${material.coilWeightStart?.toStringAsFixed(2) ?? '0'} kg'),
                                    Text(
                                        'Actual: ${material.coilWeightActual?.toStringAsFixed(2) ?? '0'} kg'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishedGoodsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Work Order Output',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Finished Goods: ${_finishedGoods.length}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_finishedGoods.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No finished goods found'),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _finishedGoods.length,
                itemBuilder: (context, index) {
                  final fg = _finishedGoods[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fg.fgDescription ?? 'Unknown Product',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (fg.note != null && fg.note!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Note: ${fg.note}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Barcode: ${fg.fgBarcode ?? ' '}'),
                                    Text('Spec: ${fg.fgSpec ?? ' '}'),
                                    Text(
                                        'Length: ${fg.fgLenght?.toStringAsFixed(2) ?? '0'} m'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Quantity: ${fg.fgQty?.toString() ?? '0'} pcs'),
                                    Text(
                                        'Weight: ${fg.fgWeightEstimate?.toStringAsFixed(2) ?? '0'} kg'),
                                    Text(
                                        'Area: ${fg.fgArea?.toStringAsFixed(2) ?? '0'} m²'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            if (_finishedGoods.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    _buildTotalRow(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow() {
    // Calculate totals
    final totalQty =
        _finishedGoods.fold<int>(0, (sum, fg) => sum + (fg.fgQty ?? 0));

    final totalWeight = _finishedGoods.fold<double>(
        0, (sum, fg) => sum + (fg.fgWeightEstimate ?? 0));

    final totalArea =
        _finishedGoods.fold<double>(0, (sum, fg) => sum + (fg.fgArea ?? 0));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Total:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$totalQty pcs',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${totalWeight.toStringAsFixed(2)} kg',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${totalArea.toStringAsFixed(2)} m²',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
