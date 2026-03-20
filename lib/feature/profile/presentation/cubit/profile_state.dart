abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {}

class GetProfileErrorState extends ProfileState {
  final String message;
  GetProfileErrorState(this.message);
}

class UpdateProfileLoadingState extends ProfileState {}

class UpdateProfileSuccessState extends ProfileState {}

class UpdateProfileErrorState extends ProfileState {
  final String message;
  UpdateProfileErrorState(this.message);
}

class ChangePasswordLoadingState extends ProfileState {}

class ChangePasswordSuccessState extends ProfileState {}

class ChangePasswordErrorState extends ProfileState {
  final String message;
  ChangePasswordErrorState(this.message);
}

class GetOrdersLoadingState extends ProfileState {}

class GetOrdersSuccessState extends ProfileState {}

class GetOrdersErrorState extends ProfileState {
  final String message;
  GetOrdersErrorState(this.message);
}