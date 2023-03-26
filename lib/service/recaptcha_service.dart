import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:web/model/recaptcha_response.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class RecaptchaService {
   static String _token = '';
   RecaptchaService._();

   static Future<void> initiate() async =>
       await GRecaptchaV3.ready(Config.siteKey);

   static Future<bool> isNotABot() async {
      var verficationResponse = await _getVerificationResponse();
      var _score = verficationResponse?.score ?? 0.0;
      print('score = $_score');
      return _score >= 0.5 && _score < 1 ? true : false;
   }

   static Future<RecaptchaResponse?> _getVerificationResponse() async {
      _token = await GRecaptchaV3.execute('login') ?? '';
      print('token: $_token');
      RecaptchaResponse? _recaptchaResponse;

      if (_token.isNotEmpty) {
         try {
            final _bodyParameters = {
               'secret': Config.secretkey,
               'response': _token,
            };

            var response = await http.post(
                Config.verficationURL,
                body: _bodyParameters,
                headers: {"Access-Control-Allow-Origin": '*'}
            );

            _recaptchaResponse = RecaptchaResponse.fromJson(response.body);
         } catch (e) {
            print('errorrrrr');
            debugPrint(e.toString());
         }
      }

      return _recaptchaResponse;
   }
}