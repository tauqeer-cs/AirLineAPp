class SearchChangeFlightRequest {
  SearchFlightRequest? searchFlightRequest;

  SearchChangeFlightRequest({this.searchFlightRequest});

  SearchChangeFlightRequest.fromJson(Map<String, dynamic> json) {
    searchFlightRequest = json['searchFlightRequest'] != null
        ? SearchFlightRequest.fromJson(json['searchFlightRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchFlightRequest != null) {
      data['searchFlightRequest'] = searchFlightRequest!.toJson();
    }
    return data;
  }

  static SearchChangeFlightRequest  makeRequestObject(
  {required String pnr, required String lastName, required DateTime? startDate, required DateTime? endDate}) {

    if(endDate == null) {
      return SearchChangeFlightRequest(
          searchFlightRequest:SearchFlightRequest(
            pNR: pnr,
            lastName: lastName,
            departDate: '${startDate!.toIso8601String()}Z',
            returnDate: null,
          )
      );
    }
    else if(startDate == null) {
      return SearchChangeFlightRequest(
          searchFlightRequest:SearchFlightRequest(
            pNR: pnr,
            lastName: lastName,
            departDate: null,
            returnDate: '${endDate.toIso8601String()}Z',
          )
      );
    }
    return SearchChangeFlightRequest(
      searchFlightRequest:SearchFlightRequest(
        pNR: pnr,
        lastName: lastName,
        departDate: '${startDate.toIso8601String()}Z',
        returnDate: '${endDate.toIso8601String()}Z',
      )
    );

  }
}

class SearchFlightRequest {
  String? departDate;
  String? returnDate;
  String? pNR;
  String? lastName;

  SearchFlightRequest(
      {this.departDate, this.returnDate, this.pNR, this.lastName});

  SearchFlightRequest.fromJson(Map<String, dynamic> json) {
    departDate = json['DepartDate'];
    returnDate = json['ReturnDate'];
    pNR = json['PNR'];
    lastName = json['LastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DepartDate'] = departDate;
    data['ReturnDate'] = returnDate;
    data['PNR'] = pNR;
    data['LastName'] = lastName;
    return data;
  }
}
