abstract class BlocEvents {}

class GetNewsBlocEvent extends BlocEvents {
  String keywordTitle;
  GetNewsBlocEvent({required this.keywordTitle});
}

