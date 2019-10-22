enum Type { pilihanGanda, benarSalah }

class QuestionModel {
  final int time;
  final Type tipe;
  final mapel;
  final subBab;
  final String pertanyaan;
  final String jwbBenar;
  final List<dynamic> jwbSalah;

  QuestionModel(this.tipe, this.pertanyaan, this.jwbBenar, this.jwbSalah,
      this.time, this.subBab, this.mapel);

  QuestionModel.fromMap(Map<String, dynamic> data)
      : tipe = data["tipe"] == "pilihan_ganda"
            ? Type.pilihanGanda
            : Type.benarSalah,
        time = data["time"],
        mapel = data["mapel"],
        subBab = data["sub_bab"],
        pertanyaan = data["pertanyaan"],
        jwbBenar = data["jawaban_benar"],
        jwbSalah = data["jawaban_salah"];

  static List<QuestionModel> fromData(List<Map<String, dynamic>> data) {
    return data.map((question) => QuestionModel.fromMap(question)).toList();
  }
}
