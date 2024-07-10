class ModelGopay {
  String statusCode;
  String statusMessage;
  String transactionId;
  String orderId;
  String grossAmount;
  String currency;
  String paymentType;
  DateTime transactionTime;
  String transactionStatus;
  String fraudStatus;
  List<Action> actions;

  ModelGopay({
    required this.statusCode,
    required this.statusMessage,
    required this.transactionId,
    required this.orderId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.actions,
  });

  factory ModelGopay.fromJson(Map<String, dynamic> json) => ModelGopay(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        actions:
            List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
      );
}

class Action {
  String name;
  String method;
  String url;

  Action({
    required this.name,
    required this.method,
    required this.url,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"],
        method: json["method"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "method": method,
        "url": url,
      };
}
