import 'dart:developer';
import 'package:bookia/feature/faq/data/models/faq_model.dart';
import 'package:bookia/feature/faq/data/repo/faq_repo.dart';
import 'package:bookia/feature/faq/presentation/cubit/faq_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());

  List<FaqModel> faqs = [];

  Future<void> getFaqs() async {
    emit(FaqLoadingState());
    try {
      faqs = await FaqRepo.getFaqs();
      log('faqs: ${faqs.length}');
      emit(FaqSuccessState());
    } catch (e) {
      log('error: $e');
      emit(FaqErrorState(e.toString()));
    }
  }
}
