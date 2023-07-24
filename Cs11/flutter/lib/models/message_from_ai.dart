class MessageAi {
  Openai openai;

  MessageAi({
    required this.openai,
  });

  factory MessageAi.fromJson(Map<String, dynamic> json) {
    return MessageAi(
      openai: Openai.fromJson(json["openai"]),
    );
  }
//
}

class Openai {
  var status;
  var generatedText;
  // List<Message> message;

  Openai({
    required this.status,
    required this.generatedText,
    // required this.message,
  });

  factory Openai.fromJson(Map<String, dynamic> json) {
    return Openai(
      status: json["status"],
      generatedText: json["generatedText"],
      // message: List.of(json["message"])
      //     .map((i) => i /* can't generate it properly yet */)
      //     .toList(),
    );
  }
//
}

