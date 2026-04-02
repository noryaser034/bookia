import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/core/services/local/shared_pref.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    getLanguage();
  }

  String languageCode = 'en';

  void getLanguage() {
    languageCode = SharedPref.getLanguage();
    emit(AppLanguageChanged());
  }

  void changeLanguage() {
    if (languageCode == 'en') {
      languageCode = 'ar';
    } else {
      languageCode = 'en';
    }
    SharedPref.setLanguage(languageCode);
    emit(AppLanguageChanged());
  }
}
