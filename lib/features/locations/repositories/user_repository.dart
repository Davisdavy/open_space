import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:on_space/features/locations/models/user.dart';

class UserRepository {
  UserRepository(this.baseUrl);
  final String baseUrl;

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('https://www.jsonkeeper.com/b/OTQQ'));

      if (response.statusCode == 200) {
        print(response.statusCode);
        final jsonData = json.decode(response.body) as List<dynamic>;

        final users = jsonData.map((dynamic json) {
          return User.fromJson(json as Map<String, dynamic>);
        }).toList();

        return users;
      } else {
        print(response.statusCode);
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}