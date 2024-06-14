class WorkorderFGModel {
  int? id;
  int? workorderId;
  String? fgBarcode;
  String? fgSpec;
  String? fgDescription;
  double? fgLenght;
  int? fgQty;
  double? fgWeightEstimate;
  double? fgArea;
  int? fgQtyActual;
  int? fgWeightActual;
  int? fgBundle;
  String? note;
  int? status;
  int? createBy;
  String? createDatetime;
  int? modifyBy;
  String? modifyDatetime;
  bool? valid;

  WorkorderFGModel(
      {this.id,
      this.workorderId,
      this.fgBarcode,
      this.fgSpec,
      this.fgDescription,
      this.fgLenght,
      this.fgQty,
      this.fgWeightEstimate,
      this.fgArea,
      this.fgQtyActual,
      this.fgWeightActual,
      this.fgBundle,
      this.note,
      this.status,
      this.createBy,
      this.createDatetime,
      this.modifyBy,
      this.modifyDatetime,
      this.valid});

  WorkorderFGModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workorderId = json['workorderId'];
    fgBarcode = json['fgBarcode'];
    fgSpec = json['fgSpec'];
    fgDescription = json['fgDescription'];
    fgLenght = json['fgLenght'];
    fgQty = json['fgQty'];
    fgWeightEstimate = json['fgWeightEstimate'];
    fgArea = json['fgArea'];
    fgQtyActual = json['fgQtyActual'];
    fgWeightActual = json['fgWeightActual'];
    fgBundle = json['fgBundle'];
    note = json['note'];
    status = json['status'];
    createBy = json['createBy'];
    createDatetime = json['createDatetime'];
    modifyBy = json['modifyBy'];
    modifyDatetime = json['modifyDatetime'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workorderId'] = this.workorderId;
    data['fgBarcode'] = this.fgBarcode;
    data['fgSpec'] = this.fgSpec;
    data['fgDescription'] = this.fgDescription;
    data['fgLenght'] = this.fgLenght;
    data['fgQty'] = this.fgQty;
    data['fgWeightEstimate'] = this.fgWeightEstimate;
    data['fgArea'] = this.fgArea;
    data['fgQtyActual'] = this.fgQtyActual;
    data['fgWeightActual'] = this.fgWeightActual;
    data['fgBundle'] = this.fgBundle;
    data['note'] = this.note;
    data['status'] = this.status;
    data['createBy'] = this.createBy;
    data['createDatetime'] = this.createDatetime;
    data['modifyBy'] = this.modifyBy;
    data['modifyDatetime'] = this.modifyDatetime;
    data['valid'] = this.valid;
    return data;
  }
}
