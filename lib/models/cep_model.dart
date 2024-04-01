import 'package:busca_cep/network/api.dart';

class Endereco {
  String cep = '';
  String logradouro = '';
  String complemento = '';
  String bairro = '';
  String localidade = '';
  String uf = '';
  String ddd = '';

  Endereco({
    this.cep = '',
    this.logradouro = '',
    this.complemento = '',
    this.bairro = '',
    this.localidade = '',
    this.uf = '',
    this.ddd = '',
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ddd: json['ddd'],
    );
  }

  Future<Endereco?> fetch(String cep) async {
    Api api = Api();
    Response response = await api.get(param: cep);

    return !response.error
        ? Endereco.fromJson(
            response.data!,
          )
        : null;
  }
}
