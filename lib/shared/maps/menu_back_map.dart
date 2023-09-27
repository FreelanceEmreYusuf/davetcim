import 'package:davetcim/src/admin_panel/AdminPanel.dart';
import 'package:davetcim/src/main/main_screen_view.dart';
import 'package:flutter/cupertino.dart';

import '../../src/admin_corporate_panel/AdminCorporatePanel.dart';

Map<String, Widget> menuBackMap =
{
  'Davetçim': null,
  'Admin Paneli': null,
  'Firma Aktif/Pasif Yönet': AdminPanelPage(),
  'Hizmet Havuzu': AdminPanelPage(),
  'Salon Özellik Yönet': AdminPanelPage(),
  'Bildirimler': MainScreen(),

  'Salon Hizmet Havuzu': AdminCorporatePanelPage(),
  'Seans Yönetimi': AdminCorporatePanelPage(),
  'Aktif Talepler': AdminCorporatePanelPage(),
  'Tüm Rezervasyonlar': AdminCorporatePanelPage(),
  'Yorum Yönetimi': AdminCorporatePanelPage(),
};




