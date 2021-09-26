class MLModel {
  int? gender;
  int? race;
  int? rank;
  int? income;
  int? gpa;
  int? gre;

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
        "race": race,
        "gpa": gpa,
        "gre": gre,
        "income": income,
        "rank": rank,
      };
}
