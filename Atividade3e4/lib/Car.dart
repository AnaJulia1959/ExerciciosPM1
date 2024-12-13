class Car {
  int? id;
  String nome;
  double KM_perL;

  Car({this.id, required this.nome, required this.KM_perL});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'KM_perL': KM_perL,
    };
  }
factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      nome: map['nome'],
      KM_perL: map['KM_perL'],
    );
  }
}