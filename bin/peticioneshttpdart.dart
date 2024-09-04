
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

void main() async {
  // URL de la API
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  // Realizar la petición GET
  final response = await http.get(url);

  print(response);

  // Verificar si la petición fue exitosa
  if (response.statusCode == 200) {
    // Parsear la respuesta JSON a una lista
    List<dynamic> jsonData = json.decode(response.body);

    // Crear una lista de Post
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    users = filterUsersByUsernameLength(users);
    // Mostrar los datos
    for (var user in users) {
      print('Id: ${user.id}');
      print('Name: ${user.name}');
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      print('---');
    }

    countUsersWithBizDomain(users);
  } else {
    // Manejo de errores
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

void countUsersWithBizDomain(List<User> users) {
  int count = users.where((user) => user.email.endsWith('.biz')).length;

  print('Cantidad de usuarios con dominio "biz": $count');
}

List<User> filterUsersByUsernameLength(List<User> users) {
  List<User> filteredUsers = users.where((user) {
    return user.username.length > 6;
  }).toList();

  return filteredUsers;
}



// print("Adrees");
// print("street: ${user.address.street}");
// print("suite: ${user.address.suite}");
// print("city: ${user.address.city}");
// print("zipcode: ${user.address.zipcode}");
// print("Geo");
// print("lat: ${user.address.geo.lat}");
// print("lng: ${user.address.geo.lng}");
// print('Phone: ${user.phone}');
// print('Website: ${user.website}');
// print("Company");
// print("name: ${user.company.name}");
// print("catchPhrase: ${user.company.catchPhrase}");
// print("bs: ${user.company.bs}");