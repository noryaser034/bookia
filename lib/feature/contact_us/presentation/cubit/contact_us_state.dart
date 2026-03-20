abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {}

class ContactUsErrorState extends ContactUsState {
  final String message;
  ContactUsErrorState(this.message);
}