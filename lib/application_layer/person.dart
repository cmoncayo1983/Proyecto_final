class Person {
  String name, cargo, nui;
  String? foto, direccion;
  int age;
  Person(
      {required this.nui,
      required this.name,
      required this.age,
      required this.cargo,
      this.foto,
      this.direccion});
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        nui: json['nui'],
        name: json['name'],
        age: json['age'],
        cargo: json['cargo'],
        foto: json['foto'],
        direccion: json['direccion']);
  }
  Map<String, dynamic> toJson() {
    return {
      'nui': nui,
      'name': name,
      'age': age,
      'cargo': cargo,
      'foto': foto,
      'direccion': direccion
    };
  }
}
