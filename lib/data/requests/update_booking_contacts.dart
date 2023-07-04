
import '../../models/confirmation_model.dart';
import 'check_in_request.dart';
import 'flight_summary_pnr_request.dart';

class UpdateBookingContact {
  String? pNR;
  String? lastName;
  int? superPNRID;
  String? superPNRNo;
  List<UpdateInfantAssociation>? updateInfantAssociation;
  List<OutboundCheckInPassengerDetails>? updatePassengerList;
  UpdateContact? updateContact;

  UpdateBookingContact(
      {this.pNR,
        this.lastName,
        this.superPNRID,
        this.superPNRNo,
        this.updateInfantAssociation,
        this.updatePassengerList,
        this.updateContact});

  UpdateBookingContact.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    superPNRID = json['SuperPNRID'];
    superPNRNo = json['SuperPNRNo'];
    if (json['UpdateInfantAssociation'] != null) {
      updateInfantAssociation = <UpdateInfantAssociation>[];
      json['UpdateInfantAssociation'].forEach((v) {
        updateInfantAssociation!.add( UpdateInfantAssociation.fromJson(v));
      });
    }
    if (json['UpdatePassengerList'] != null) {
      updatePassengerList = <OutboundCheckInPassengerDetails>[];
      json['UpdatePassengerList'].forEach((v) {
        updatePassengerList!.add( OutboundCheckInPassengerDetails.fromJson(v));
      });
    }
    updateContact = json['UpdateContact'] != null
        ? new UpdateContact.fromJson(json['UpdateContact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PNR'] = this.pNR;
    data['LastName'] = lastName;
    data['SuperPNRID'] = this.superPNRID;
    data['SuperPNRNo'] = this.superPNRNo;
    if (this.updateInfantAssociation != null) {
      data['UpdateInfantAssociation'] =
          this.updateInfantAssociation!.map((v) => v.toJson()).toList();
    }
    if (this.updatePassengerList != null) {
      data['UpdatePassengerList'] =
          this.updatePassengerList!.map((v) => v.toJson()).toList();
    }
    if (this.updateContact != null) {
      data['UpdateContact'] = this.updateContact!.toJson();
    }
    return data;
  }
}

class UpdateInfantAssociation {
  String? infantLastName;
  String? infantFirstName;
  String? adultPersonOrgID;

  UpdateInfantAssociation(
      {this.infantLastName, this.infantFirstName, this.adultPersonOrgID});

  UpdateInfantAssociation.fromJson(Map<String, dynamic> json) {
    infantLastName = json['InfantLastName'];
    infantFirstName = json['InfantFirstName'];
    adultPersonOrgID = json['AdultPersonOrgID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InfantLastName'] = this.infantLastName;
    data['InfantFirstName'] = this.infantFirstName;
    data['AdultPersonOrgID'] = this.adultPersonOrgID;
    return data;
  }
}


class UpdateContact {
  BookingContact? bookingContact;
  EmergencyContact? emergencyContact;
  CompanyContact? companyContact;

  UpdateContact(
      {this.bookingContact, this.emergencyContact, this.companyContact});

  UpdateContact.fromJson(Map<String, dynamic> json) {
    bookingContact = json['BookingContact'] != null
        ? new BookingContact.fromJson(json['BookingContact'])
        : null;
    emergencyContact = json['EmergencyContact'] != null
        ? new EmergencyContact.fromJson(json['EmergencyContact'])
        : null;
    companyContact = json['CompanyContact'] != null
        ? new CompanyContact.fromJson(json['CompanyContact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingContact != null) {
      data['BookingContact'] = this.bookingContact!.toJson();
    }
    if (this.emergencyContact != null) {
      data['EmergencyContact'] = this.emergencyContact!.toJson();
    }
    if (this.companyContact != null) {
      data['CompanyContact'] = this.companyContact!.toJson();
    }
    return data;
  }
}



class CompanyContact {
  String? companyName;
  String? companyAddress;
  String? country;
  String? state;
  String? city;
  String? postCode;
  String? emailAddress;

  CompanyContact(
      {this.companyName,
        this.companyAddress,
        this.country,
        this.state,
        this.city,
        this.postCode,
        this.emailAddress});

  CompanyContact.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    companyAddress = json['CompanyAddress'];
    country = json['Country'];
    state = json['State'];
    city = json['City'];
    postCode = json['PostCode'];
    emailAddress = json['EmailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyName'] = this.companyName;
    data['CompanyAddress'] = this.companyAddress;
    data['Country'] = this.country;
    data['State'] = this.state;
    data['City'] = this.city;
    data['PostCode'] = this.postCode;
    data['EmailAddress'] = this.emailAddress;
    return data;
  }
}