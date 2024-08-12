class Contact {
  int? _id;
  String? _name;
  String? _phone;
  String? _imgUrl;

  Contact(dynamic Obj) {
    _id = Obj['id'];
    _name = Obj['name'];
    _phone = Obj['phone'];
    _imgUrl = Obj['imgUrl'];
  }

  toMap() {
    var map = {
      'id': _id,
      'name': _name,
      'phone': _phone,
      'imgUrl': _imgUrl,
    };
    return map;
  }

  Contact.fromMap(Map map) {
    _id = map['id'];
    _name = map['name'];
    _phone = map['phone'];
    _imgUrl = map['imgUrl'];
  }

  get id => _id;
  get name => _name;
  get phone => _phone;
  get imgUrl => _imgUrl;
}
