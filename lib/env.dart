// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'APIKEYWEB', obfuscate: true)
  static String apiKeyWeb = _Env.apiKeyWeb;

  @EnviedField(varName: 'APIKEYANDROID', obfuscate: true)
  static String apiKeyAndroid = _Env.apiKeyAndroid;

  @EnviedField(varName: 'APIKEYIOS', obfuscate: true)
  static String apiKeyIos = _Env.apiKeyIos;

  @EnviedField(varName: 'APIKEYWINDOWS', obfuscate: true)
  static String apiKeyWindows = _Env.apiKeyWindows;

  @EnviedField(varName: 'APIKEYMAC', obfuscate: true)
  static String apiKeyMac = _Env.apiKeyMac;
}
