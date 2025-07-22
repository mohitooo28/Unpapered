class OnBoardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingModel(
      {required this.image, required this.title, required this.subtitle});
}

final List<OnBoardingModel> onBoardData = [
  OnBoardingModel(image: OnBoardImg1, title: Title1, subtitle: SubTitle1),
  OnBoardingModel(image: OnBoardImg2, title: Title2, subtitle: SubTitle2),
  OnBoardingModel(image: OnBoardImg3, title: Title3, subtitle: SubTitle3),
];

const String Title1 = "PDFs Reinvented \nwith AI";
const String Title2 = "AI-Powered Doc Dynamo";
const String Title3 = "Intuitive Interface";

const String SubTitle1 =
    "Your PDF, your personal assistant\nChat, Learn, Explore";
const String SubTitle2 =
    "Harnessing AI to transform your PDFs into a dynamic resource";
const String SubTitle3 =
    "Elegant interface, effortless communication with your documents.";

const String OnBoardImg1 = "assets/onboard/brd1.json";
const String OnBoardImg2 = "assets/onboard/brd2.json";
const String OnBoardImg3 = "assets/onboard/brd3.json";
