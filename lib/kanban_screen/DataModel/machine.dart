class MachineModel {
  int? id;
  String? name;
  String? description;
  int? locationId;
  int? createBy;
  String? createDatetime;
  int? modifyBy;
  String? modifyDatetime;
  bool? valid;

  MachineModel(
      {this.id,
      this.name,
      this.description,
      this.locationId,
      this.createBy,
      this.createDatetime,
      this.modifyBy,
      this.modifyDatetime,
      this.valid});

  MachineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    locationId = json['locationId'];
    createBy = json['createBy'];
    createDatetime = json['createDatetime'];
    modifyBy = json['modifyBy'];
    modifyDatetime = json['modifyDatetime'];
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['locationId'] = locationId;
    data['createBy'] = createBy;
    data['createDatetime'] = createDatetime;
    data['modifyBy'] = modifyBy;
    data['modifyDatetime'] = modifyDatetime;
    data['valid'] = valid;
    return data;
  }
}
