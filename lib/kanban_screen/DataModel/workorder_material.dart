

class WorkorderMaterialModel {
  int? id;
  int? workorderId;
  String? specoilBarcode;
  String? specoilCode;
  String? specoilDescription;
  String? lot;
  String? coilNo;
  double? coilWeightStart;
  double? coilWeightStartActual;
  double? coilWeightEstimate;
  double? coilWeightActual;
  double? coilWeightRemaining;
  int? status;
  int? createBy;
  String? createDatetime;
  int? modifyBy;
  String? modifyDatetime;
  bool? valid;
  String? remark;

  WorkorderMaterialModel(
      {this.id,
        this.workorderId,
        this.specoilBarcode,
        this.specoilCode,
        this.specoilDescription,
        this.lot,
        this.coilNo,
        this.coilWeightStart,
        this.coilWeightStartActual,
        this.coilWeightEstimate,
        this.coilWeightActual,
        this.coilWeightRemaining,
        this.status,
        this.createBy,
        this.createDatetime,
        this.modifyBy,
        this.modifyDatetime,
        this.valid,
        this.remark});

  WorkorderMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workorderId = json['workorderId'];
    specoilBarcode = json['specoilBarcode'];
    specoilCode = json['specoilCode'];
    specoilDescription = json['specoilDescription'];
    lot = json['lot'];
    coilNo = json['coilNo'];
    coilWeightStart = json['coilWeightStart'];
    coilWeightStartActual = json['coilWeightStartActual'];
    coilWeightEstimate = json['coilWeightEstimate'];
    coilWeightActual = json['coilWeightActual'];
    coilWeightRemaining = json['coilWeightRemaining'];
    status = json['status'];
    createBy = json['createBy'];
    createDatetime = json['createDatetime'];
    modifyBy = json['modifyBy'];
    modifyDatetime = json['modifyDatetime'];
    valid = json['valid'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workorderId'] = this.workorderId;
    data['specoilBarcode'] = this.specoilBarcode;
    data['specoilCode'] = this.specoilCode;
    data['specoilDescription'] = this.specoilDescription;
    data['lot'] = this.lot;
    data['coilNo'] = this.coilNo;
    data['coilWeightStart'] = this.coilWeightStart;
    data['coilWeightStartActual'] = this.coilWeightStartActual;
    data['coilWeightEstimate'] = this.coilWeightEstimate;
    data['coilWeightActual'] = this.coilWeightActual;
    data['coilWeightRemaining'] = this.coilWeightRemaining;
    data['status'] = this.status;
    data['createBy'] = this.createBy;
    data['createDatetime'] = this.createDatetime;
    data['modifyBy'] = this.modifyBy;
    data['modifyDatetime'] = this.modifyDatetime;
    data['valid'] = this.valid;
    data['remark'] = this.remark;
    return data;
  }




}
