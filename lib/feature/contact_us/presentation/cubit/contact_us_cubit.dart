import 'package:bookia/feature/contact_us/data/contact_us_repo.dart';
import 'package:bookia/feature/contact_us/presentation/cubit/contact_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  Future<void> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    emit(ContactUsLoadingState());
    try {
      await ContactUsRepo.sendMessage(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );
      emit(ContactUsSuccessState());
    } catch (e) {
      emit(ContactUsErrorState(e.toString()));
    }
  }
}