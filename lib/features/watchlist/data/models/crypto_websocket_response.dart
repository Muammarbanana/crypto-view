import 'package:json_annotation/json_annotation.dart';

part 'crypto_websocket_response.g.dart';

@JsonSerializable()
class CryptoWebsocketResponse {
  const CryptoWebsocketResponse({
    this.s,
    this.p,
    this.q,
    this.dc,
    this.dd,
    this.t,
  });

  factory CryptoWebsocketResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoWebsocketResponseFromJson(json);
  @JsonKey(name: 's')
  final String? s;
  @JsonKey(name: 'p')
  final String? p;
  @JsonKey(name: 'q')
  final String? q;
  @JsonKey(name: 'dc')
  final String? dc;
  @JsonKey(name: 'dd')
  final String? dd;
  @JsonKey(name: 't')
  final int? t;

  Map<String, dynamic> toJson() => _$CryptoWebsocketResponseToJson(this);
}
