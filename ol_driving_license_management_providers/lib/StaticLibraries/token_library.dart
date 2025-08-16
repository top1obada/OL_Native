import 'dart:convert';
import 'package:ol_driving_license_management_dto/LoginDTOs/current_login_information.dart';

class TokenLibrary {
  TokenLibrary._();

  static Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final payloadBytes = base64Url.decode(normalized);
    final payloadString = utf8.decode(payloadBytes);

    return json.decode(payloadString);
  }

  static ClsCurrentLoginInformationDTO? extractLoginInfoFromToken(
    String? token,
  ) {
    if (token == null) return null;

    Map<String, dynamic> payload = _parseJwt(token);

    // Parse PersonID from string to int
    int? personId;
    if (payload.containsKey('PersonID') && payload['PersonID'] != null) {
      personId = int.tryParse(payload['PersonID'].toString());
    }

    // Parse UserID from string to int
    int? userId;
    if (payload.containsKey('UserID') && payload['UserID'] != null) {
      userId = int.tryParse(payload['UserID'].toString());
    }

    // Parse IsActive from string to boolean
    int? traineeID;
    if (payload.containsKey('TraineeID') && payload['TraineeID'] != null) {
      traineeID = int.tryParse(payload['TraineeID'].toString());
    }

    // Parse JoiningDate from string to DateTime
    DateTime? parseCustomDate(String dateString) {
      try {
        // تنسيق yyyy/MM/dd
        final parts = dateString.split('/');
        if (parts.length == 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final day = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
        return null;
      } catch (e) {
        print('Error parsing date: $e');
        return null;
      }
    }

    // الاستخدام:
    DateTime? joiningDate;
    if (payload.containsKey('JoiningDate') && payload['JoiningDate'] != null) {
      final dateString = payload['JoiningDate'].toString();
      joiningDate = parseCustomDate(dateString);
    }

    return ClsCurrentLoginInformationDTO.fromJson({
      'FirstName':
          payload.containsKey('FirstName') ? payload['FirstName'] : null,
      'UserName': payload.containsKey('UserName') ? payload['UserName'] : null,
      'PersonID': personId,
      'UserID': userId,
      'JoiningDate': joiningDate,
      'TraineeID': traineeID,
    });
  }
}
