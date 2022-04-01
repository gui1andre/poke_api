import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:poke_api/src/components/pokemon.dart';
import 'package:poke_api/src/web_api/web_api.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'teste',
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController nomePoke = TextEditingController();
  final Chamadas _webClient = Chamadas();
  late bool ativo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const PokedexButton(),
        leadingWidth: 300,
        title: const Text('Pokedex'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: nomePoke,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<Pokemon>(
            future: _webClient.searchPokemon(nomePoke.text),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.waiting:
                  // TODO: Handle this case.
                  return const Progress();
                case ConnectionState.active:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.done:
                  // TODO: Handle this case.

                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.name.capitalize(),
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Image.network(snapshot.data!.linkImage),
                          Text('${snapshot.data?.tipo.types?.toString()}')
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: const [
                      CenteredMessage(
                        'Pokemon não encontrado',
                        icon: Icons.warning,
                      ),
                    ],
                  );
              }
              return const CenteredMessage(
                'Unknown error',
                icon: Icons.error,
              );
            },
          ),
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final String message;

  const Progress({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[const CircularProgressIndicator(), Text(message)],
      ),
    );
  }
}

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  const CenteredMessage(
    this.message, {
    required this.icon,
    this.iconSize = 64,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              message,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class PokedexButton extends StatefulWidget {
  const PokedexButton({Key? key}) : super(key: key);

  @override
  State<PokedexButton> createState() => _PokedexButtonState();
}

class _PokedexButtonState extends State<PokedexButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white)),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withOpacity(0.4))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.4))),
            ),
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black.withOpacity(0.4))),
          ),
        ],
      ),
    );
  }
}
