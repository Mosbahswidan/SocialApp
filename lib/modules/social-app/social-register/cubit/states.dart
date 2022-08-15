

abstract class SocialRegisterStates{}
class SocialRegisterIntial extends SocialRegisterStates{}
class SocialRegisterSucsses extends SocialRegisterStates{}
class SocialRegisterError extends SocialRegisterStates{
  final String error;

  SocialRegisterError(this.error);
}

class SocialCreateUserSucsses extends SocialRegisterStates{}
class SocialCreateUserError extends SocialRegisterStates{
  final String error;

  SocialCreateUserError(this.error);
}
class SocialRegisterLoading extends SocialRegisterStates{}
class SocialRegisterSecure extends SocialRegisterStates{}