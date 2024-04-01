import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  String url;

  Api({
    this.url = 'viacep.com.br/ws',
  });

  Future<Response> get({required String param}) async {
    try {
      String resource = 'https://$url/$param/json/';
      http.Response response = await http.get(
        Uri.parse(
          resource,
        ),
      );

      print('Retorno do endpoint $resource: ${response.body}');

      if (response.statusCode < 300) {
        return Response(
          error: false,
          statusCode: response.statusCode,
          data: jsonDecode(response.body),
          body: response.body,
        );
      } else {
        return Response(
          error: true,
          statusCode: response.statusCode,
          data: null,
          body: null,
        );
      }
    } catch (e) {
      print('Erro: $e');
    }
    return Response(
      error: true,
      statusCode: 401,
      data: null,
    );
  }
}

class Response {
  final bool error;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? body;
  Response({
    required this.error,
    this.data,
    required this.statusCode,
    this.body,
  });
}
