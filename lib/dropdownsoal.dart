import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> arrtodropdown(List<String> arr) {
  List<DropdownMenuItem<String>> x = arr
      .map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black))))
      .toList();
  return x;
}

List<DropdownMenuItem<String>> arrtodropdownmatpel(String matpel) {
  if (matpel == "Kimia") {
    return arrtodropdown(kimia);
  } else if (matpel == "Fisika") {
    return arrtodropdown(fisika);
  } else if (matpel == "Matematika") {
    return arrtodropdown(matematika);
  } else if (matpel == "Biologi") {
    return arrtodropdown(biologi);
  } else {
    return arrtodropdown(semuabab);
  }
}

String matpeltodropvalue(String matpel) {
  if (matpel == "Kimia") {
    return kimia[0];
  } else if (matpel == "Fisika") {
    return fisika[0];
  } else if (matpel == "Matematika") {
    return matematika[0];
  } else if (matpel == "Biologi") {
    return biologi[0];
  } else {
    return "Semua";
  }
}

const matpel = <String>['Matematika', 'Fisika', 'Kimia', 'Biologi', 'Semua'];
const matpelwithoutsemua = <String>['Matematika', 'Fisika', 'Kimia', 'Biologi'];

List<String> matematika = <String>[
  'Aljabar',
  'Trigonometri',
  'Bangun Ruang',
  'Fungsi',
  'Semua'
];
List<String> fisika = <String>[
  'Vektor',
  'Dinamika Rotasi',
  'Dinamika Gerak',
  'Listrik',
  'Semua'
];
List<String> biologi = <String>['Sel', 'Jaringan', 'Sistem Tubuh', 'Semua'];
List<String> kimia = <String>['Atom', 'Kim. Unsur', 'Kim. Organik', 'Semua'];
List<String> semua = <String>['Semua'];
var semuabab =
    [matematika, kimia, fisika, biologi].expand((x) => x).toSet().toList();

const soal = <String>['SIMAK UI', 'SBMPTN', 'UM', 'Semua'];
String _btnsoal = "Semua";

const String _btnBabSelected = "Semua Bab";
