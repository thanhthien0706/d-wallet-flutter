class CardModel {
  int? id;
  String? expYear;
  String? expMonth;
  String? codeLast4;
  String? number;
  String? brand;
  String? country;
  String? cvc;

  CardModel(
      {this.id,
      this.expYear,
      this.expMonth,
      this.codeLast4,
      this.brand,
      this.country,
      this.number,
      this.cvc});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json["id"],
      expYear: json["expYear"],
      expMonth: json["expMonth"],
      codeLast4: json["codeLast4"],
      brand: json["brand"],
      country: json["country"],
      number: json["number"],
      cvc: json["cvc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expYear': expYear,
      'expMonth': expMonth,
      'codeLast4': codeLast4,
      'brand': brand,
      'country': country,
      'number': number,
      'cvc': cvc,
    };
  }
}
