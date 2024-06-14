class WorkorderModel {
  int? id;
  String? woId;
  String? woBarcode;
  String? woDate;
  String? ipo;
  String? prqId;
  String? project;
  String? prdCompletionDeadline;
  int? machineId;
  int? laborQty;
  String? actualFinish;
  String? actualStart;
  int? fgTotalWeight;
  int? downgread15;
  int? downgrade22;
  int? downgrade3;
  int? downgradeWeight;
  int? scrapWeight;
  int? downtime;
  int? setuptime;
  int? status;
  int? createBy;
  String? createDatetime;
  int? modifyBy;
  String? modifyDatetime;
  bool? valid;
  String? lineName;

  WorkorderModel(
      {this.id,
      this.woId,
      this.woBarcode,
      this.woDate,
      this.ipo,
      this.prqId,
      this.project,
      this.prdCompletionDeadline,
      this.machineId,
      this.laborQty,
      this.actualFinish,
      this.actualStart,
      this.fgTotalWeight,
      this.downgread15,
      this.downgrade22,
      this.downgrade3,
      this.downgradeWeight,
      this.scrapWeight,
      this.downtime,
      this.setuptime,
      this.status,
      this.createBy,
      this.createDatetime,
      this.modifyBy,
      this.modifyDatetime,
      this.valid});

  WorkorderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    woId = json['woId'];
    woBarcode = json['woBarcode'];
    woDate = json['woDate'];
    ipo = json['ipo'];
    prqId = json['prqId'];
    project = json['project'];
    prdCompletionDeadline = json['prdCompletionDeadline'];
    machineId = json['machineId'];
    laborQty = json['laborQty'];
    actualFinish = json['actualFinish'];
    actualStart = json['actualStart'];
    fgTotalWeight = json['fgTotalWeight'];
    downgread15 = json['downgread15'];
    downgrade22 = json['downgrade22'];
    downgrade3 = json['downgrade3'];
    downgradeWeight = json['downgradeWeight'];
    scrapWeight = json['scrapWeight'];
    downtime = json['downtime'];
    setuptime = json['setuptime'];
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
    data['woId'] = this.woId;
    data['woBarcode'] = this.woBarcode;
    data['woDate'] = this.woDate;
    data['ipo'] = this.ipo;
    data['prqId'] = this.prqId;
    data['project'] = this.project;
    data['prdCompletionDeadline'] = this.prdCompletionDeadline;
    data['machineId'] = this.machineId;
    data['laborQty'] = this.laborQty;
    data['actualFinish'] = this.actualFinish;
    data['actualStart'] = this.actualStart;
    data['fgTotalWeight'] = this.fgTotalWeight;
    data['downgread15'] = this.downgread15;
    data['downgrade22'] = this.downgrade22;
    data['downgrade3'] = this.downgrade3;
    data['downgradeWeight'] = this.downgradeWeight;
    data['scrapWeight'] = this.scrapWeight;
    data['downtime'] = this.downtime;
    data['setuptime'] = this.setuptime;
    data['status'] = this.status;
    data['createBy'] = this.createBy;
    data['createDatetime'] = this.createDatetime;
    data['modifyBy'] = this.modifyBy;
    data['modifyDatetime'] = this.modifyDatetime;
    data['valid'] = this.valid;
    data['lineName'] = this.lineName;
    return data;
  }
}
