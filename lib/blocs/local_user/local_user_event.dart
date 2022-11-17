part of 'local_user_bloc.dart';

abstract class LocalUserEvent extends Equatable {
  const LocalUserEvent();
}

class Init extends LocalUserEvent{
  const Init();
  @override
  List<Object?> get props => [];
}

class UpdateData extends LocalUserEvent{
  final FlightSummaryPnrRequest? data;
  const UpdateData(this.data);
  @override
  List<Object?> get props => [data];
}

class UpdateEmailContact extends LocalUserEvent{
  final String? email;
  const UpdateEmailContact(this.email);
  @override
  List<Object?> get props => [email];
}

class UpdateEmergency extends LocalUserEvent{
  final EmergencyContact? emergencyContact;
  const UpdateEmergency(this.emergencyContact);
  @override
  List<Object?> get props => [emergencyContact];
}

class UpdateCompany extends LocalUserEvent{
  final CompanyTaxInvoice? companyInfo;
  const UpdateCompany(this.companyInfo);
  @override
  List<Object?> get props => [companyInfo];
}