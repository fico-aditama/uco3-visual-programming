import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
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
  static Future<User?> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle network errors or JSON parsing errors
      print('Error: $e');
      return null;
    }
  }
  void printUser() {
    print('User ID      : $id');
    print('Name         : $firstName $lastName');
    print('Age          : $age');
    print('Gender       : $gender');
    print('Email        : $email');
    print('Phone        : $phone');
    print('Username     : $username');
    print('Password     : $password');
    print('Birth Date   : $birthDate');
    print('Image        : $image');
    print('Blood Group  : $bloodGroup');
    print('Height       : $height');
    print('Weight       : $weight');
    print('Eye Color    : $eyeColor');
    print('Hair Color   : $hairColor');
    print('Hair Type    : $hairType');
    print('Domain       : $domain');
    print('IP Address   : $ipAddress');
    print('Address      : $address');
    print('City         : $city');
    print('Latitude     : $userLatitude');
    print('Longitude    : $userLongitude');
    print('Postal Code  : $postalCode');
    print('State        : $userState');
    print('MAC Address  : $macAddress');
    print('University   : $university');
    print('Bank Expire  : $bankCardExpire');
    print('Bank Number  : $bankCardNumber');
    print('Bank Type    : $bankCardType');
    print('Currencies   : $bankCurrencies');
    print('Bank IBAN    : $bankIban');
    print('Company Address   : $companyAddress');
    print('Company City      : $companyCity');
    print('Company Latitude  : $companyLatitude');
    print('Company Longitude : $companyLongitude');
    print('Company Postal Code: $companyPostalCode');
    print('Company State     : $companyState');
    print('Company Department: $companyDepartment');
    print('Company Name      : $companyName');
    print('Company Title     : $companyTitle');
    print('EIN               : $ein');
    print('SSN               : $ssn');
    print('User Agent        : $userAgent');
    print('\n');
  }
}

void main() async {
  final baseUrl = 'https://dummyjson.com/users/';
  final numberOfUsers = 10; // Ganti dengan jumlah pengguna yang Anda inginkan

  for (int i = 1; i <= numberOfUsers; i++) {
    final user = await User.fetchData('$baseUrl$i');
    if (user != null) {
      user.printUser();
    }
  }
}
