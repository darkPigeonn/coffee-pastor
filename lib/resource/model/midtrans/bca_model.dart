class ModelBca {
    String statusCode;
    String statusMessage;
    String transactionId;
    String orderId;
    String merchantId;
    String grossAmount;
    String currency;
    String paymentType;
    DateTime transactionTime;
    String transactionStatus;
    List<VaNumber> vaNumbers;
    String fraudStatus;

    ModelBca({
        required this.statusCode,
        required this.statusMessage,
        required this.transactionId,
        required this.orderId,
        required this.merchantId,
        required this.grossAmount,
        required this.currency,
        required this.paymentType,
        required this.transactionTime,
        required this.transactionStatus,
        required this.vaNumbers,
        required this.fraudStatus,
    });

    factory ModelBca.fromJson(Map<String, dynamic> json) => ModelBca(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        vaNumbers: List<VaNumber>.from(json["va_numbers"].map((x) => VaNumber.fromJson(x))),
        fraudStatus: json["fraud_status"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_status": transactionStatus,
        "va_numbers": List<dynamic>.from(vaNumbers.map((x) => x.toJson())),
        "fraud_status": fraudStatus,
    };
}

class VaNumber {
    String bank;
    String vaNumber;

    VaNumber({
        required this.bank,
        required this.vaNumber,
    });

    factory VaNumber.fromJson(Map<String, dynamic> json) => VaNumber(
        bank: json["bank"],
        vaNumber: json["va_number"],
    );

    Map<String, dynamic> toJson() => {
        "bank": bank,
        "va_number": vaNumber,
    };
}