import 'package:app/data/requests/book_request.dart';

class MmbCheckoutRequest {

  PaymentDetail? paymentDetail;
  String? token;
  String? insertVoucher;
  String? superPNRNo;

  MmbCheckoutRequest(
      {this.paymentDetail, this.token, this.insertVoucher, this.superPNRNo});

  MmbCheckoutRequest.fromJson(Map<String, dynamic> json) {
    paymentDetail = json['PaymentDetail'] != null
        ? PaymentDetail.fromJson(json['PaymentDetail'])
        : null;
    token = json['Token'];
    insertVoucher = json['InsertVoucher'];
    superPNRNo = json['SuperPNRNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentDetail != null) {
      data['PaymentDetail'] = paymentDetail!.toJson();
    }
    data['Token'] = token;
    data['InsertVoucher'] = insertVoucher;
    data['SuperPNRNo'] = superPNRNo;
    return data;
  }
}
