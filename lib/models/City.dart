class City {
  int id;
  String name;

  City( this.id, this.name );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'name': name,
    };
    return map;
  }

  City.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}