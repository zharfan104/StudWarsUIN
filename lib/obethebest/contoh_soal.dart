import 'package:flutter_firebase_login/oneonone/question_model.dart';

const Map<int, dynamic> jawabanBenar = {
  0: "ibu",
  1: "sepupu",
  2: "ibu",
  3: "sepupu",
  4: "ibu",
};

final List<QuestionModel> listModelPertanyaan = QuestionModel.fromData([
  {
    "time": 200,
    "tipe": "pilihan_ganda",
    "mapel": "sopan santun",
    "sub_bab": "sapaan",
    "pertanyaan":
        "Diberikan kubus ABCD.EFGH dengan permukaan berbahan karton. Sebuah titik P terletk pada rusuk CG sehingga CP : PG = 2 : 5. Jika bidan PBD membagi kubus menjadi dua bagian, perbandingan luas permukaan karton adalah ",
    "jawaban_benar": "73 :11",
    "jawaban_salah": ["73 : 17", "	73 : 15", "71 :12", "73 : 9 "]
  },
  {
    "time": 200,
    "tipe": "benarSalah",
    "mapel": "sopan santun",
    "sub_bab": "sapaan",
    "pertanyaan":
        "Diketahui balok ABCD.EFGH dengan Panjang AB = 6, BC = 4, dan CG = 2. Jika titik M perpanjangan AB sehingga MB = 2AB, titik N perpanjangan FG sehingga FG = GN dan ɵ adalah sudut antara MN dan MB, maka sin ɵ adalah ",
    "jawaban_benar": "√17 / √53",
    "jawaban_salah": ["1 / √53", "2√17 / √53", "2 / √17", "√17 / 2√53"]
  },
  {
    "time": 200,
    "tipe": "pilihan_ganda",
    "mapel": "sopan santun",
    "sub_bab": "sapaan",
    "pertanyaan":
        "Diberikan bidang empat 𝐴. 𝐵𝐶𝐷 dengan 𝐵𝐶 tegak lurus 𝐵𝐷, dan 𝐴𝐵 tegaklurus bidang 𝐵𝐶𝐷. Jika 𝐵𝐶 = 𝐵𝐷 = 𝑎√2 cm, dan 𝐴𝐵 = 𝑎 cm, maka sudut antara bidang 𝐴𝐶𝐷 dan 𝐵𝐶𝐷 sama dengan ?",
    "jawaban_benar": "𝜋/4 ",
    "jawaban_salah": ["	𝜋/6 ", "𝜋/3 ", "3𝜋/4 ", "𝜋/2"]
  },
  {
    "time": 200,
    "tipe": "pilihan_ganda",
    "mapel": "sopan santun",
    "sub_bab": "sapaan",
    "pertanyaan":
        "Diberikan bidang empat 𝐴. 𝐵𝐶𝐷 dengan 𝐵𝐶 tegak lurus 𝐵𝐷, dan 𝐴𝐵 tegaklurus bidang 𝐵𝐶𝐷. Jika 𝐵𝐶 = 𝐵𝐷 = 𝑎√2 cm, dan 𝐴𝐵 = 𝑎 cm, maka sudut antara bidang 𝐴𝐶𝐷 dan 𝐵𝐶𝐷 sama dengan ?",
    "jawaban_benar": "𝜋/4 ",
    "jawaban_salah": ["	𝜋/6 ", "𝜋/3 ", "3𝜋/4 ", "𝜋/2"]
  },
]);
