class ContactModel {
  int? id;//identitas datanya
  String? name;
  String? phone;
  String? email;

  ContactModel({this.email, this.id, this.name, this.phone});

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      email: map['email'], 
      id : map['id'],
      name: map['name'], 
      phone: map['phone']
    );
  }

Map<String, dynamic> toMap() {
  return {'id' : id, 'name': name, 'email': email, 'phone': phone };
}
}

if (imounted) return;

if(confirm == true) {
  navigator.of(context).pop("delete");
}