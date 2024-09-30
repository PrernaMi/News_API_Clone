abstract class BlocEvents {}

class GetEveryThingNewsBlocEvent extends BlocEvents {
  String keywordTitle;
  GetEveryThingNewsBlocEvent({required this.keywordTitle});
}

class GetHeadingNewsBlocEvent extends BlocEvents {}
