class Pokemon {
  final String name;
  final String linkImage;
  final Tipo tipo;

  Pokemon(this.tipo, this.name, this.linkImage);

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        linkImage = json['sprites']['front_default'],
        tipo = Tipo.fromJson(json);

  @override
  String toString() {
    return 'Pokemon{name: $name, linkImage: $linkImage, tipo: $tipo}';
  }
}

class Tipo {
  List<Types>? types;

  Tipo({this.types});

  Tipo.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  Type? type;

  Types({this.type});

  Types.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Type {
  String? name;

  Type({
    this.name,
  });

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;

    return data;
  }
}
