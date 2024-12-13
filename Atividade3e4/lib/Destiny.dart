class Destiny {
  int? id;
  String nomeCidade;
  double KM;

  Destiny({this.id, required this.nomeCidade, required this.KM});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCidade': nomeCidade,
      'KM': KM,
    };
  }

  factory Destiny.fromMap(Map<String, dynamic> map) {
    return Destiny(
      id: map['id'],
      nomeCidade: map['nomeCidade'],
      KM: map['KM'],
    );
  }
}