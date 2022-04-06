class Pokemon {
  final String name;
  final String linkImage;
  final Tipo tipo;
  final Habilidades habilidades;
  final Status status;

  Pokemon(this.tipo, this.name, this.linkImage, this.habilidades, this.status);

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        linkImage = json['sprites']['front_default'],
        tipo = Tipo.fromJson(json),
        habilidades = Habilidades.fromJson(json),
        status = Status.fromJson(json);

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

class Habilidades {
  Habilidades({
    required this.abilities,
  });

  late final List<Abilities> abilities;

  Habilidades.fromJson(Map<String, dynamic> json) {
    abilities =
        List.from(json['abilities']).map((e) => Abilities.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['abilities'] = abilities.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Abilities {
  Abilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  late final Ability ability;
  late final bool isHidden;
  late final int slot;

  Abilities.fromJson(Map<String, dynamic> json) {
    ability = Ability.fromJson(json['ability']);
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ability'] = ability.toJson();
    _data['is_hidden'] = isHidden;
    _data['slot'] = slot;
    return _data;
  }
}

class Ability {
  Ability({
    required this.name,
    required this.url,
  });

  late final String name;
  late final String url;

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}



class Status {
  List<Stats>? stats;
  List<Types>? types;

  Status({this.stats, this.types});

  Status.fromJson(Map<String, dynamic> json) {
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  int? baseStat;
  int? effort;
  Stat? stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    return data;
  }
}

class Stat {
  String? name;
  String? url;

  Stat({this.name, this.url});

  Stat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Types_Status {
  int? slot;
  Stat? type;

  Types_Status({this.slot, this.type});

  Types_Status.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Stat.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}
