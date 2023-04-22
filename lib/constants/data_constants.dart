import 'package:ski_resorts_app/onboardingpage.dart';
import 'package:ski_resorts_app/constants/text_constants.dart';
import 'package:ski_resorts_app/constants/path_constants.dart';

class DataConstants {
  // Onboarding
  // Una lista di oggetti  onboardingTile
  static final onboardingTiles = [
    const OnboardingPage(
      title: TextConstants.onboarding1Title,
      mainText: TextConstants.onboarding1Description,
      imagePath: PathConstants.onboarding1,
    ),
    const OnboardingPage(
      title: TextConstants.onboarding2Title,
      mainText: TextConstants.onboarding2Description,
      imagePath: PathConstants.onboarding2,
    ),
    const OnboardingPage(
      title: TextConstants.onboarding3Title,
      mainText: TextConstants.onboarding3Description,
      imagePath: PathConstants.onboarding3,
    ),
  ];
}
