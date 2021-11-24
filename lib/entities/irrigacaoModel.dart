import 'package:cloud_firestore/cloud_firestore.dart';

class IrrigacaoModel {
  Timestamp? data;
  double? fluxo;
  double? volume;
  bool? solenoide;

  IrrigacaoModel({
    this.data,
    this.fluxo = 0.0,
    this.volume = 0.0,
    this.solenoide = false,
  });

  IrrigacaoModel.fromMap(Map<String, dynamic> map) {
    this.data = map['data'];
    this.fluxo = map['fluxo'];
    this.volume = map['volume'];
  }

  Map<String, dynamic> toMap() {
    return {
      "data": this.data,
      "fluxo": this.fluxo,
      "volume": this.volume,
    };
  }

  // factory IrrigacaoModel.fromJson(Map<String, dynamic> json) {
  //   return IrrigacaoModel(
  //     data: json['data'],
  //     fluxo: json['fluxo'],
  //     volume: json['volume'],
  //     solenoide: json['solenoide'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "data": data!,
  //     "fluxo": fluxo,
  //     "volume": volume,
  //     "solenoide": solenoide,
  //   };
  // }
}
