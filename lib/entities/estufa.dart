import 'package:cloud_firestore/cloud_firestore.dart';

class EstufaModel {
  String? uid;
  double? umidade;
  double? temperatura;
  double? umidadeSolo;
  bool? ligada;

  EstufaModel({
    this.uid,
    this.umidade,
    this.umidadeSolo,
    this.temperatura,
    this.ligada,
    // this.umidade = 0.0,
    // this.umidadeSolo = 0.0,
    // this.temperatura = 0.0
  });

  EstufaModel.fromMap(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.umidade = map['umidade'];
    this.umidadeSolo = map['umidadeSolo'];
    this.temperatura = map['temperatura'];
    this.ligada = map['ligada'];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "umidade": this.umidade,
      "umidadeSolo": this.umidadeSolo,
      "temperatura": this.temperatura,
      "ligada": this.ligada,
    };
  }
}
