// // lib/api_service.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String apiUrl =
//       'https://i3soaiap2jdwtm3lk6ygvje3ie.appsync-api.us-east-1.amazonaws.com/graphql';
//   // 'https://gqkcdholp5cohfjofmi5ereh6q.appsync-api.us-east-1.amazonaws.com/graphql';
//   static const String apiKey = 'da2-zp4pfcf43jhotixugpv64cjutu';

//   static Future<List<SmartHelmet>> fetchSmartHelmets() async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'x-api-key': apiKey,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'query': '''
//           // query MyQuery {
//           //   listSmartHelmets(limit: 10) {
//           //     items {
//           //       Device_ID
//           //       Env_temp
//           //       Gas
//           //       Hrt
//           //       Obj_temp
//           //       lat
//           //       lng
//           //       time
//           //     }
//           //   }
//           // }

//           query MyQuery {
//   listSmartHelmets(limit:10) {
//     items {
//       Device_ID
//       Env_temp
//       Hrt
//       Obj_temp
//       VOLATILE_GAS
//       CARBON_MONOXIDE
//       NITROGEN_DIOXIDE
//       ALCOHOL
//       lat
//       lng
//       time
//     }
//   }
// }

//         '''
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> items = data['data']['listSmartHelmets']['items'];
//       return items.map((item) => SmartHelmet.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }

// class SmartHelmet {
//   final String deviceId;
//   final double envTemp;
//   final String hrt;
//   final double objTemp;
//   final double lat;
//   final double lng;
//   final int time;

//   SmartHelmet({
//     required this.deviceId,
//     required this.envTemp,
//     required this.hrt,
//     required this.objTemp,
//     required this.lat,
//     required this.lng,
//     required this.time,
//   });

//   factory SmartHelmet.fromJson(Map<String, dynamic> json) {
//     return SmartHelmet(
//       deviceId: json['Device_ID'],
//       envTemp: json['Env_temp'] != null
//           ? double.parse(json['Env_temp'].toString())
//           : 0.0,
//       hrt: json['Hrt'],
//       objTemp: json['Obj_temp'] != null
//           ? double.parse(json['Obj_temp'].toString())
//           : 0.0,
//       lat: json['lat'] != null ? double.parse(json['lat'].toString()) : 0.0,
//       lng: json['lng'] != null ? double.parse(json['lng'].toString()) : 0.0,
//       time: json['time'],
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl =
      'https://i3soaiap2jdwtm3lk6ygvje3ie.appsync-api.us-east-1.amazonaws.com/graphql';
  static const String apiKey = 'da2-zp4pfcf43jhotixugpv64cjutu';

  static Future<List<SmartHelmet>> fetchSmartHelmets() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': '''
          query MyQuery {
            listSmartHelmets(limit: 10) {
              items {
                Device_ID
                Env_temp
                Hrt
                Obj_temp
                VOLATILE_GAS
                CARBON_MONOXIDE
                NITROGEN_DIOXIDE
                ALCOHOL
                lat
                lng
                time
              }
            }
          }
        '''
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> items = data['data']['listSmartHelmets']['items'];
      return items.map((item) => SmartHelmet.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class SmartHelmet {
  final String deviceId;
  final double envTemp;
  final String hrt;
  final double objTemp;
  final double volatileGas;
  final double carbonMonoxide;
  final double nitrogenDioxide;
  final double alcohol;
  final double lat;
  final double lng;
  final int time;

  SmartHelmet({
    required this.deviceId,
    required this.envTemp,
    required this.hrt,
    required this.objTemp,
    required this.volatileGas,
    required this.carbonMonoxide,
    required this.nitrogenDioxide,
    required this.alcohol,
    required this.lat,
    required this.lng,
    required this.time,
  });

  factory SmartHelmet.fromJson(Map<String, dynamic> json) {
    return SmartHelmet(
      deviceId: json['Device_ID'],
      envTemp: json['Env_temp'] != null
          ? double.parse(json['Env_temp'].toString())
          : 0.0,
      hrt: json['Hrt'],
      objTemp: json['Obj_temp'] != null
          ? double.parse(json['Obj_temp'].toString())
          : 0.0,
      volatileGas: json['VOLATILE_GAS'] != null
          ? double.parse(json['VOLATILE_GAS'].toString())
          : 0.0,
      carbonMonoxide: json['CARBON_MONOXIDE'] != null
          ? double.parse(json['CARBON_MONOXIDE'].toString())
          : 0.0,
      nitrogenDioxide: json['NITROGEN_DIOXIDE'] != null
          ? double.parse(json['NITROGEN_DIOXIDE'].toString())
          : 0.0,
      alcohol: json['ALCOHOL'] != null
          ? double.parse(json['ALCOHOL'].toString())
          : 0.0,
      lat: json['lat'] != null ? double.parse(json['lat'].toString()) : 0.0,
      lng: json['lng'] != null ? double.parse(json['lng'].toString()) : 0.0,
      time: json['time'],
    );
  }
}

// mod2//
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String apiUrl =
//       'https://gqkcdholp5cohfjofmi5ereh6q.appsync-api.us-east-1.amazonaws.com/graphql';
//   static const String apiKey = 'da2-cyunamd6nbflldcccltx433xwa';

//   static Future<List<SmartHelmet>> fetchSmartHelmets() async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'x-api-key': apiKey,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'query': '''
//           query MyQuery {
//             listSmarthelmets(limit: 100) {
//               items {
//                 Device_ID
//                 Env_temp
//                 Gas
//                 Hrt
//                 Obj_temp
//                 lat
//                 lng
//                 time
//               }
//             }
//           }
//         '''
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final List<dynamic> items = data['data']['listSmarthelmets']['items'];
//       return items.map((item) => SmartHelmet.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }

// class SmartHelmet {
//   final String deviceId;
//   final double envTemp;
//   final double gas;
//   final double hrt;
//   final double objTemp;
//   final double lat;
//   final double lng;
//   final int time;

//   SmartHelmet({
//     required this.deviceId,
//     required this.envTemp,
//     required this.gas,
//     required this.hrt,
//     required this.objTemp,
//     required this.lat,
//     required this.lng,
//     required this.time,
//   });

//   factory SmartHelmet.fromJson(Map<String, dynamic> json) {
//     return SmartHelmet(
//       deviceId: json['Device_ID'],
//       envTemp: json['Env_temp'] != null
//           ? double.parse(json['Env_temp'].toString())
//           : 0.0,
//       gas: json['Gas'] != null ? double.parse(json['Gas'].toString()) : 0.0,
//       hrt: json['Hrt'],
//       objTemp: json['Obj_temp'] != null
//           ? double.parse(json['Obj_temp'].toString())
//           : 0.0,
//       lat: json['lat'] != null ? double.parse(json['lat'].toString()) : 0.0,
//       lng: json['lng'] != null ? double.parse(json['lng'].toString()) : 0.0,
//       time: json['time'],
//     );
//   }
// }

//mod 3 12.15pm//
