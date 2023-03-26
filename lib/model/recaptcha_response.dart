import 'dart:convert';
import 'package:flutter/foundation.dart';

class RecaptchaResponse {

  late final bool success;
  late final DateTime challengeTimeStamp;
  late final String hostName;

  //score range 0.0 - 1.0 where 1.0 is a human
  late final double score;

  late final String action;
  late final List<String> errorCodes;

  RecaptchaResponse({
   required this.success,
   required this.challengeTimeStamp,
   required this.hostName,
   required this.score,
   required this.action,
   this.errorCodes = const [],
  });

  RecaptchaResponse copyWith({
    bool? success,
    DateTime? challengeTimeStamp,
    String? hostName,
    double? score,
    String? action,
    List<String>? errorCodes,
  }) {
    return RecaptchaResponse(
        success: success ?? this.success,
        challengeTimeStamp: challengeTimeStamp ?? this.challengeTimeStamp,
        hostName: hostName ?? this.hostName,
        score: score ?? this.score,
        action: action ?? this.action
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'challengeTimeStamp': challengeTimeStamp.millisecondsSinceEpoch,
      'hostname': hostName,
      'score': score,
      'action': action,
      'error-codes': errorCodes
    };
  }

  factory RecaptchaResponse.fromMap(Map<String, dynamic> map) {
    return RecaptchaResponse(
      success: map['success'] ?? false,
      challengeTimeStamp: DateTime.parse(map['challenge_ts']),
      hostName: map['hostname'] ?? '',
      score: map['score']?.toDouble() ?? 0.0,
      action: map['action'] ?? '',
      errorCodes: map['error-codes'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecaptchaResponse.fromJson(String source) =>
      RecaptchaResponse.fromMap(json.decode(source));

  @override
  String toString() {
    // TODO: implement toString
    return 'RecaptchaResponse(success: $success, challengeTimeStamp: $challengeTimeStamp, hostName: $hostName, score: $score, action: $action, errorCodes: $errorCodes)';
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    if (identical(this, other)) return true;

    return other is RecaptchaResponse &&
        other.success == success &&
        other.challengeTimeStamp == challengeTimeStamp &&
        other.hostName == hostName &&
        other.score == score &&
        other.action == action &&
        listEquals(other.errorCodes, errorCodes);    ;
  }

  @override
  // TODO: implement hashCode
  int get hashCode {
    return success.hashCode ^
      challengeTimeStamp.hashCode ^
      hostName.hashCode ^
      score.hashCode ^
      action.hashCode ^
      errorCodes.hashCode;
  }
}