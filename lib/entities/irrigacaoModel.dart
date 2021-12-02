import 'package:cloud_firestore/cloud_firestore.dart';

class IrrigacaoModel {
  Timestamp? data;
  double? fluxo;
  double? volume;

  IrrigacaoModel(this.data, this.fluxo, this.volume);

  IrrigacaoModel.fromMap(Map<String, dynamic> map)
      : assert(map['data'] != null),
        assert(map['fluxo'] != null),
        assert(map['volume'] != null),
        data = map['data'],
        fluxo = map['fluxo'],
        volume = map['volume'];

  @override
  String toString() => "Record<$data:$fluxo:$volume>";
}
