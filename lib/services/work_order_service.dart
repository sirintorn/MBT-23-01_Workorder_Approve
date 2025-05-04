import 'dart:convert';
import 'package:http/http.dart' as http;

import '../DataModel/workorder.dart';
import '../DataModel/workorder_material.dart';
import '../DataModel/workorder_fg.dart';
import '../DataModel/machine.dart';

class WorkOrderService {
  final String baseUrl;

  WorkOrderService({required this.baseUrl});

  Future<Map<String, dynamic>> getWorkOrderReport(String workOrderId) async {
    try {
      print('Fetching work order data for ID: $workOrderId from $baseUrl');

      // Fetch the Work Order data
      final workOrderUri = Uri.parse('$baseUrl/MBTService/api/getWorkOrderSingle/$workOrderId');
      print('Work Order URI: $workOrderUri');

      final workOrderResponse = await http.get(workOrderUri);

      print('Work Order Response status: ${workOrderResponse.statusCode}');
      print('Work Order Response body raw: ${workOrderResponse.body}');

      if (workOrderResponse.statusCode != 200) {
        throw Exception('Failed to load work order data. Status: ${workOrderResponse.statusCode}');
      }

      // Try to parse the response in different formats
      WorkorderModel? workOrder;

      try {
        // Try parsing as a List first (common format)
        final dynamic jsonData = json.decode(workOrderResponse.body);
        print('JSON data type: ${jsonData.runtimeType}');

        if (jsonData is List && jsonData.isNotEmpty) {
          print('Parsing as List[0]');
          workOrder = WorkorderModel.fromJson(jsonData[0]);
        }
        // Try parsing as a direct object
        else if (jsonData is Map<String, dynamic>) {
          print('Parsing as direct Map');
          workOrder = WorkorderModel.fromJson(jsonData);
        }
        // Try parsing as a nested object with 'data' field
        else if (jsonData != null &&
            jsonData is Map &&
            jsonData.containsKey('data') &&
            jsonData['data'] != null) {
          var data = jsonData['data'];
          print('Parsing from data field, type: ${data.runtimeType}');

          if (data is List && data.isNotEmpty) {
            workOrder = WorkorderModel.fromJson(data[0]);
          } else if (data is Map<String, dynamic>) {
            workOrder = WorkorderModel.fromJson(data);
          }
        }
      } catch (e) {
        print('Error parsing work order JSON: $e');
      }

      if (workOrder == null) {
        throw Exception('Invalid work order data format for ID: $workOrderId');
      }

      print('Successfully parsed work order: ${workOrder.woId}');

      // Fetch Materials with flexible parsing
      List<WorkorderMaterialModel> materials = [];
      try {
        final materialsUri = Uri.parse('$baseUrl/MBTService/api/getWorkOrderMaterial/$workOrderId');
        print('Materials URI: $materialsUri');

        final materialsResponse = await http.get(materialsUri);
        print('Materials Response status: ${materialsResponse.statusCode}');

        if (materialsResponse.statusCode == 200) {
          final dynamic jsonData = json.decode(materialsResponse.body);
          print('Materials JSON type: ${jsonData.runtimeType}');

          if (jsonData is List) {
            materials = jsonData
                .map((item) => WorkorderMaterialModel.fromJson(item))
                .toList();
          } else if (jsonData is Map && jsonData.containsKey('data') && jsonData['data'] is List) {
            materials = (jsonData['data'] as List)
                .map((item) => WorkorderMaterialModel.fromJson(item))
                .toList();
          }

          print('Parsed ${materials.length} materials');
        }
      } catch (e) {
        print('Error fetching materials (continuing with empty list): $e');
      }

      // Fetch Finished Goods with flexible parsing
      List<WorkorderFGModel> finishedGoods = [];
      try {
        final fgUri = Uri.parse('$baseUrl/MBTService/api/getWorkOrderFG/$workOrderId');
        print('Finished Goods URI: $fgUri');

        final fgResponse = await http.get(fgUri);
        print('Finished Goods Response status: ${fgResponse.statusCode}');

        if (fgResponse.statusCode == 200) {
          final dynamic jsonData = json.decode(fgResponse.body);
          print('Finished Goods JSON type: ${jsonData.runtimeType}');

          if (jsonData is List) {
            finishedGoods = jsonData
                .map((item) => WorkorderFGModel.fromJson(item))
                .toList();
          } else if (jsonData is Map && jsonData.containsKey('data') && jsonData['data'] is List) {
            finishedGoods = (jsonData['data'] as List)
                .map((item) => WorkorderFGModel.fromJson(item))
                .toList();
          }

          print('Parsed ${finishedGoods.length} finished goods');
        }
      } catch (e) {
        print('Error fetching finished goods (continuing with empty list): $e');
      }

      // Create machine data safely
      Map<String, dynamic>? machineData;
      if (workOrder.machineId != null) {
        machineData = {
          'id': workOrder.machineId,
          'name': workOrder.lineName ?? 'Unknown Machine',
          'description': 'Machine for work order ${workOrder.woId}'
        };
        print('Created machine data: $machineData');
      }

      return {
        'workOrder': workOrder,
        'materials': materials,
        'finishedGoods': finishedGoods,
        'machineData': machineData,
      };
    } catch (e) {
      print('*** ERROR in getWorkOrderReport: $e');
      throw Exception('Error fetching work order data: $e');
    }
  }

  // Utility method to try fetching raw data for debugging
  Future<String> getRawData(String endpoint, String id) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint/$id');
      final response = await http.get(uri);
      return 'Status: ${response.statusCode}, Body: ${response.body}';
    } catch (e) {
      return 'Error: $e';
    }
  }
}