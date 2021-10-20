class BreastModel {
  BreastModelSection radius = BreastModelSection();
  BreastModelSection texture = BreastModelSection();
  BreastModelSection perimeter = BreastModelSection();
  BreastModelSection area = BreastModelSection();
  BreastModelSection smoothness = BreastModelSection();
  BreastModelSection compactness = BreastModelSection();
  BreastModelSection concavity = BreastModelSection();
  BreastModelSection points = BreastModelSection();
  BreastModelSection symmetry = BreastModelSection();
  BreastModelSection fractalDimensions = BreastModelSection();


  Map<String, dynamic> toMap() => {
    "radius": radius.toMap(),
    "area": area.toMap(),
    "compactness": compactness.toMap(),
    "concavity": concavity.toMap(),
    "fractalDimensions": fractalDimensions.toMap(),
    "perimeter": perimeter.toMap(),
    "points": points.toMap(),
    "smoothness": smoothness.toMap(),
    "symmetry": symmetry.toMap(),
    "texture": texture.toMap(),
  };
}

class BreastModelSection{
  double? mean;
  double? se;
  double? worst;

  BreastModelSection({
    this.mean,
    this.se,
    this.worst,
  });

  Map<String, dynamic> toMap() => {
    "mean": mean,
    "se": se,
    "worst": worst,
  };

  void assignValues(double mean, double se, double worst){
    this.mean = mean;
    this.se = se;
    this.worst = worst;
  }

}