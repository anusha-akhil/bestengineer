class Autogenerated {
  List<Area>? area;

  Autogenerated({this.area});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['area'] != null) {
      area = <Area>[];
      json['area'].forEach((v) {
        area!.add(new Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.area != null) {
      data['area'] = this.area!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Area {
  String? areaId;
  String? areaName;

  Area({this.areaId, this.areaName});

  Area.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    return data;
  }
}