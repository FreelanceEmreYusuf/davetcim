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

const List<String> organizationType = const <String>[
  'DÜĞÜN',
  'KINA',
  'NİŞAN',
  'DOĞUM GÜNÜ',
  'EVLİLİK TEKLİFİ',
  'BABYSHOWER',
  'CİNSİYET PARTİSİ',
  'İFTAR',
  'TOPLANTI',
  'SEMPOZYUM',
  'KORONA PARTİ',
  'ALTIN GÜNÜ',
];

const List<String> venueType = const <String>[
  'OTEL',
  'BALO SALONU',
  'DÜĞÜN SALONU',
  'RESTAURANT',
  'CAFE',
  'PUB',
  'BAR',
  'HEPSİ',
];

const List<String> seatingArrangement = const <String>[
  'SIRA DÜZENİ',
  'BALO DÜZENİ',
  'YUVARLAK DÜZEN',
  'ŞARK KÖŞESİ',
  'DİKEY DÜZEN',
  'YATAY DÜZEN',
];

class SearchViewModel extends ChangeNotifier {
  Database db = Database();
}
