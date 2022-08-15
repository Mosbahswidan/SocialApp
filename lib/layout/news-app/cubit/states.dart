abstract class AppStatenews{}


class AppIntealnewsState extends AppStatenews{}
class AppBottomNavnewsState extends AppStatenews{}
class AppNewsGetDataState extends AppStatenews{}
class AppNewsGetDataErrorState extends AppStatenews{
  final String error;

  AppNewsGetDataErrorState(this.error);
}


class AppSportsGetDataState extends AppStatenews{}
class AppSportsGetDataErrorState extends AppStatenews{
  final String error;

  AppSportsGetDataErrorState(this.error);
}


class AppScinceGetDataState extends AppStatenews{}
class AppScinceGetDataErrorState extends AppStatenews{
  final String error;

  AppScinceGetDataErrorState(this.error);
}
class AppSearchGetDataState extends AppStatenews{}
class AppSearchGetDataErrorState extends AppStatenews{
  final String error;

  AppSearchGetDataErrorState(this.error);
}


