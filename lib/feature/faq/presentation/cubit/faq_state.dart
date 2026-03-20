abstract class FaqState {}

class FaqInitial extends FaqState {}

class FaqLoadingState extends FaqState {}

class FaqSuccessState extends FaqState {}

class FaqErrorState extends FaqState {
  final String message;
  FaqErrorState(this.message);
}