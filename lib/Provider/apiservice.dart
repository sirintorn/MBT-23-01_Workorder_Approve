import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mbt_workorder_approve/ServerAndConfig/config.dart';

class APIService {
  static Future<dynamic> getAllMachines() async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getAllMachine',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> addMachine(
      String name, String ipAddress, int modifiedBy) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json
        .encode({"name": name, "ipAddress": ipAddress, "modifyBy": modifiedBy});
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}postMachine',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> deleteWorkOrder(id) async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}delWorkOrder/${id.toString()}',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> getMachineWorkOrder(int machineId) async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getMachineWorkOrder/$machineId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> updateWorkorderStatus(
      int workorderId, int stakeholderId, int status) async {
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}updateWorkorderStatus/${workorderId.toString()}/${stakeholderId.toString()}/${status.toString()}',
      options: Options(
        method: 'PUT',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> getWorkordersKanban() async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getTodayWorkorderKanban',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> getWorkorderDetails(int workorderId) async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getWorkorderDetails/$workorderId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> getWorkorderMaterials(int workorderId) async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getWorkorderMaterials/$workorderId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }

  static Future<dynamic> getWorkorderFG(int workorderId) async {
    var dio = Dio();
    var response = await dio.request(
      '${Configuration.apiServer}getWorkorderFG/$workorderId',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return (response.statusMessage);
    }
  }
}
