// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_websocket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoWebsocketResponse _$CryptoWebsocketResponseFromJson(
        Map<String, dynamic> json) =>
    CryptoWebsocketResponse(
      s: json['s'] as String?,
      p: json['p'] as String?,
      q: json['q'] as String?,
      dc: json['dc'] as String?,
      dd: json['dd'] as String?,
      t: (json['t'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CryptoWebsocketResponseToJson(
        CryptoWebsocketResponse instance) =>
    <String, dynamic>{
      's': instance.s,
      'p': instance.p,
      'q': instance.q,
      'dc': instance.dc,
      'dd': instance.dd,
      't': instance.t,
    };
