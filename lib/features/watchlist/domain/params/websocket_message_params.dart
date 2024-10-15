import 'dart:convert';

class WebSocketMessageParams {
  const WebSocketMessageParams({this.action, this.symbols});

  final String? action;
  final List<String>? symbols;

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        if (action != null) 'action': action,
        if (symbols != null) 'symbols': symbols?.join(','),
      };
}
