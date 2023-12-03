import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  // Definisikan atribut-atribut
  final int id;
  final String firstName;
  final String lastName;
  final String hairColor;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;
  final String bloodGroup;
  final int height;
  final double weight;
  final String eyeColor;
  final String hairType;
  final String domain;
  final String ipAddress;
  final String address;
  final String city;
  final double userLatitude;
  final double userLongitude;
  final String postalCode;
  final String userState;
  final String macAddress;
  final String university;
  final String bankCardExpire;
  final String bankCardNumber;
  final String bankCardType;
  final String bankCurrencies;
  final String bankIban;
  final String companyAddress;
  final String companyCity;
  final double companyLatitude;
  final double companyLongitude;
  final String companyPostalCode;
  final String companyState;
  final String companyDepartment;
  final String companyName;
  final String companyTitle;
  final String ein;
  final String ssn;
  final String userAgent;

  User({
    // Definisi Konstruktor
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.hairColor,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairType,
    required this.domain,
    required this.ipAddress,
    required this.address,
    required this.city,
    required this.userLatitude,
    required this.userLongitude,
    required this.postalCode,
    required this.userState,
    required this.macAddress,
    required this.university,
    required this.bankCardExpire,
    required this.bankCardNumber,
    required this.bankCardType,
    required this.bankCurrencies,
    required this.bankIban,
    required this.companyAddress,
    required this.companyCity,
    required this.companyLatitude,
    required this.companyLongitude,
    required this.companyPostalCode,
    required this.companyState,
    required this.companyDepartment,
    required this.companyName,
    required this.companyTitle,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      hairColor: json['hair']['color'] ?? 'N/A',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      username: json['username'] ?? 'N/A',
      password: json['password'] ?? 'N/A',
      birthDate: json['birthDate'] ?? 'N/A',
      image: json['image'] ?? 'N/A',
      bloodGroup: json['bloodGroup'] ?? 'N/A',
      height: json['height'] ?? 0,
      weight: json['weight']?.toDouble() ?? 0.0,
      eyeColor: json['eyeColor'] ?? 'N/A',
      hairType: json['hair']['type'] ?? 'N/A',
      domain: json['domain'] ?? 'N/A',
      ipAddress: json['ip'] ?? 'N/A',
      address: json['address']['address'] ?? 'N/A',
      city: json['address']['city'] ?? 'N/A',
      userLatitude: json['address']['coordinates']['lat']?.toDouble() ?? 0.0,
      userLongitude: json['address']['coordinates']['lng']?.toDouble() ?? 0.0,
      postalCode: json['postalCode'] ?? 'N/A',
      userState: json['state'] ?? 'N/A',
      macAddress: json['macAddress'] ?? 'N/A',
      university: json['university'] ?? 'N/A',
      bankCardExpire: json['bank']['cardExpire'] ?? 'N/A',
      bankCardNumber: json['bank']['cardNumber'] ?? 'N/A',
      bankCardType: json['bank']['cardType'] ?? 'N/A',
      bankCurrencies: json['bank']['currency'] ?? 'N/A',
      bankIban: json['bank']['iban'] ?? 'N/A',
      companyAddress: json['company']['address']['address'] ?? 'N/A',
      companyCity: json['company']['address']['city'] ?? 'N/A',
      companyLatitude: json['company']['address']['coordinates']['lat']?.toDouble() ?? 0.0,
      companyLongitude: json['company']['address']['coordinates']['lng']?.toDouble() ?? 0.0,
      companyPostalCode: json['company']['address']['postalCode'] ?? 'N/A',
      companyState: json['company']['address']['state'] ?? 'N/A',
      companyDepartment: json['company']['department'] ?? 'N/A',
      companyName: json['company']['name'] ?? 'N/A',
      companyTitle: json['company']['title'] ?? 'N/A',
      ein: json['ein'] ?? 'N/A',
      ssn: json['ssn'] ?? 'N/A',
      userAgent: json['userAgent'] ?? 'N/A',
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String baseUrl = 'https://dummyjson.com/users/';
  int numberOfUsers = 20; // Ganti dengan jumlah pengguna yang Anda inginkan
  List<User> userList = [];
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      for (int i = 1; i <= numberOfUsers; i++) {
        final response = await http.get(Uri.parse('$baseUrl$i'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final user = User.fromJson(data);
          setState(() {
            userList.add(user);
          });
        } else {
          print('Failed to load data for user $i');
        }
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showUserDetails(User user) {
    // Menampilkan detail informasi pengguna di sini
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('User Personal'),
                Text('Name    : ${user.firstName} ${user.lastName}'),
                Text('Birth   : ${user.birthDate}'),
                Text('Age     : ${user.age}'),
                Text('Gender  : ${user.gender}'),
                Text('Height  : ${user.height}'),
                Text('Width   : ${user.weight}'),
                Text('Hair Color : ${user.hairColor}'),
                Text('Hair Type : ${user.hairType}'),
                Text('Eye Color : ${user.eyeColor}'),

                _buildSectionTitle('User Account'),
                Text('Username: ${user.username}'),
                Text('Password: ${user.password}'),
                Text('Email   : ${user.email}'),
                Text('Phone   : ${user.phone}'),
                Text('Address : ${user.address}'),
                Text('City    : ${user.city}'),
                Text('Postal  : ${user.postalCode}'),
                Text('State   : ${user.userState}'),
                Text('Image: ${user.image}'),
                Text('Mac Address: ${user.macAddress}'),
                Text('University: ${user.university}'),

                _buildSectionTitle('User Bank'),
                Text('Bank Card Number: ${user.bankCardNumber}'),
                Text('Bank Card Expire: ${user.bankCardExpire}'),
                Text('Bank Card Type: ${user.bankCardType}'),
                Text('Bank Currencies: ${user.bankCurrencies}'),
                Text('Bank Iban: ${user.bankIban}'),

                _buildSectionTitle('User Company'),
                Text('Company : ${user.companyName}'),
                Text('Address : ${user.companyAddress}'),
                Text('City : ${user.companyCity}'),
                Text('Latitude : ${user.companyLatitude}'),
                Text('Longitude : ${user.companyLongitude}'),
                Text('Postal Code : ${user.companyPostalCode}'),
                Text('State : ${user.companyState}'),
                Text('Department : ${user.companyDepartment}'),
                Text('Title : ${user.companyTitle}'),

                _buildSectionTitle('User Logs'),
                Text('Domain : ${user.domain}'),
                Text('Ip Address : ${user.ipAddress}'),
                Text('Latitude : ${user.userLatitude}'),
                Text('Longtitude: ${user.userLongitude}'),
                Text('ein : ${user.ein}'),
                Text('ssn : ${user.ssn}'),
                Text('Agent : ${user.userAgent}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : error.isNotEmpty
          ? Center(
        child: Text(error),
      )
          : userList.isEmpty
          ? Center(
        child: Text('No users available.'),
      )
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('First Name')),
            DataColumn(label: Text('Last Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Details')),
          ],
          rows: userList
              .map(
                (user) => DataRow(
              cells: [
                DataCell(Text(user.firstName)),
                DataCell(Text(user.lastName)),
                DataCell(Text(user.email)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showUserDetails(user);
                    },
                  ),
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              userList.clear();
              fetchUsers();
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}