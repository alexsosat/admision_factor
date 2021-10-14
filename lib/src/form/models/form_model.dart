class MLModel {
  int? gender;
  int? race;
  int? rank;
  int? income;
  double? gpa;
  double? gre;

  MLModel({
    this.gender,
    this.race,
    this.gpa,
    this.gre,
    this.income,
    this.rank,
  });

  Map<String, dynamic> toMap() => {
        "gender": gender,
        "ethnic": race,
        "gpa": gpa,
        "gre": gre,
        "income": income,
        "prestige": rank,
      };
}
