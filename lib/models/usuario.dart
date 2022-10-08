// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        required this.name,
        required this.email,
        required this.photo,
        required this.phone,
        required this.online,
        required this.lic,
        required this.uid,
    });

    String name;
    String email;
    dynamic photo;
    String phone;
    bool online;
    bool lic;
    String uid;
// Serializar
    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        phone: json["phone"],
        online: json["online"],
        lic: json["lic"],
        uid: json["uid"],
    );
// Deserializar
    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "photo": photo,
        "phone": phone,
        "online": online,
        "lic": lic,
        "uid": uid,
    };
}
