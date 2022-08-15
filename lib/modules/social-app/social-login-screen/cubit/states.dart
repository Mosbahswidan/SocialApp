abstract class SocialLoginStates{}
class SocialLoginIntial extends SocialLoginStates{}
class SocialLoginSucsses extends SocialLoginStates{
  final String uId;

  SocialLoginSucsses(this.uId);
}
class SocialLoginError extends SocialLoginStates{
  final String error;
  SocialLoginError(this.error);
}
class SocialLoginLoading extends SocialLoginStates{}
class SocialLoginChangeSecure extends SocialLoginStates{}