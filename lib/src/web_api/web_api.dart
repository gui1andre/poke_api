import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../components/pokemon.dart';

import 'interceptor.dart';

class Chamadas {



  Future<Pokemon> searchPokemon(String nomePoke) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nomePoke');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final pokemon = Pokemon.fromJson(json);
      return pokemon;
    } else {
      throw Exception('Erro ao conectar com o servidor');
    }
  }

  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
}
