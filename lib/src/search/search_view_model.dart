import 'package:davetcim/shared/services/database.dart';
import 'package:flutter/cupertino.dart';

const List<String> country = const <String>[
  'İSTANBUL(TÜMÜ)',
  'İSTANBUL(AVR)',
  'İSTANBUL(ASYA)',
  'ANKARA',
  'İZMİR',
  'ANTALYA',
  'KOCAELİ',
  'SAKARYA',
  'DİYERBAKIR',
  'MUĞLA',
  'BURSA',
  'ÇANAKKALE',
];

const List<String> district = const <String>[
  'SARIYER',
  'KAĞITHANE',
  'EYÜP',
  'ESENLER',
  'BAĞCILAR',
  'ÜSKÜDAR',
  'ÜMRANİYE',
  'KÜÇÜKÇEKMECE',
  'BÜYÜKÇEKMECE',
  'ÜSKÜDAR',
  'ÜMRANİYE',
  'ATAŞEHİR',
];

class SearchViewModel extends ChangeNotifier {
  Database db = Database();
}
