class Consultation {
  int id;
  String name;
  String date;
  String status;
  String notice;
  String upcoming;
  String note;

  Consultation(this.id, this.name, this.date, this.status, this.note,
      this.notice, this.upcoming);
}

List<Consultation> demoConst = [
  Consultation(22, "Madour Amina", "02/01/2023", "Complete", "/",
      "madour_021223", "02/04/2023"),
  Consultation(
      32, "Asqoub Kamel", "02/01/2023", "Analyse", "/", "asqoub_021223", "-"),
  Consultation(25, "Ben gourir Noura", "02/01/2023", "Complete", "/",
      "ben_gourir_021223", "02/04/2023"),
  Consultation(43, "Bouan Yassmina", "02/01/2023", "Complete", "/",
      "bouan_021223", "02/04/2023"),
  Consultation(99, "Gilass M'hend", "02/01/2023", "Current", "/", "-", "-")
];
