class Favorite {
  final String skiResortUrl;
  final String skiResortName;
  final String skiResortDescription;
  final String imageLink;
  final double skiResortRating;
  final String totalSkiSlopes;
  final String blueSkiSlopes;
  final String redSkiSlopes;
  final String blackSkiSlopes;
  final String skiPassCost;
  final String skiResortElevation;
  final String skiLiftsNumber;

  Favorite(
      {required this.skiResortUrl,
      required this.skiResortName,
      required this.skiResortDescription,
      required this.imageLink,
      required this.skiResortRating,
      required this.totalSkiSlopes,
      required this.blueSkiSlopes,
      required this.redSkiSlopes,
      required this.blackSkiSlopes,
      required this.skiPassCost,
      required this.skiResortElevation,
      required this.skiLiftsNumber});
}
