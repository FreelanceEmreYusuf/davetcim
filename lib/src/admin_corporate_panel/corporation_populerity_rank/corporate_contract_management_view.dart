import 'package:davetcim/shared/helpers/corporate_helper.dart';
import 'package:davetcim/shared/models/corporation_model.dart';
import 'package:davetcim/shared/sessions/organization_items_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/sessions/user_state.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/expanded_card_widget.dart';
import '../../../widgets/indicator.dart';

class CorporationPopularityRankView extends StatefulWidget {
  @override
  _CorporationPopularityRankViewState createState() => _CorporationPopularityRankViewState();

  CorporationPopularityRankView(
      {Key key,
        })
      : super(key: key);
}

class _CorporationPopularityRankViewState extends State<CorporationPopularityRankView> {

  CorporationModel corporationModel;
  bool hasDataTaken = false;
  List<CorporationModel> corporationList =[];
  List<CorporationModel> corporationListWithCity =[];

  @override
  void initState() {
    getCorporationPopularityPoint();
    super.initState();
  }

  void getCorporationPopularityPoint() async {
    CorporateHelper corporateHelper = CorporateHelper();
    corporationModel = await corporateHelper.getCorporate(UserState.corporationId);
    corporationList = await corporateHelper.getPopularFirst100Corporate();
    corporationListWithCity = await corporateHelper.getPopularFirst100CorporateWithCity(corporationModel.region);
    setState(() {
      corporationModel = corporationModel;
      corporationList = corporationList;
      corporationListWithCity = corporationListWithCity;
      hasDataTaken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Populerlik Bilgisi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    return Scaffold(
      appBar: AppBarMenu(pageName: "Populerlik Bilgisi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/filter_page_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.1), // Filtre yoğunluğu
            ],
          ),
        ),
        child: InkWell(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height / 50,),
                        ListTile(
                          title: Text( "Salonunuzun Populerlik Bilgisi", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                          trailing: Text( "Puan", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                        ),
                        Card(
                          elevation: 10.0,
                          child: ListTile(
                            title: Text( corporationModel.corporationName, style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.redAccent,
                            ),),
                            leading: Icon(
                              FontAwesomeIcons.solidStar,
                              size: 25.0,
                              color: Theme.of(context).accentColor,
                            ),
                            subtitle: Text( "Populerlik Puanı", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),),
                            trailing: Text( corporationModel.point.toString(), style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.redAccent,
                            ),),
                          ),
                        ),
                        Card(
                          elevation: 10.0,
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text( "Popülerlik puanı arama/filtreleme sonuçlarında mekanınızın üst sıralarda/önlerde listelenmesini, davetcim uygulamasının "+
                                  "müşterilere mekanınızı ve organizasyonunuzu tavsiye etmesini ve davetcim uygulamasının ana sayfasında bulunan "+
                                  "En Popüler Salonlar başlığı altında mekanınızın listelenmesini sağlar. \n\nPuanınız ne kadar yüksekse o kadar öne çıkarsınız, kullanıcı "+
                                  "etkileşiminiz, kurumsal prestijiniz, müşteriye verdiğiniz güven poplerlik puanınıza paralel olarak artar, popülerlik puanınızı artırmak için aşağıdaki faktörleri inceleyebilirsiniz.", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Colors.black54,
                              ),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                        ExpandableCard(
                            collapsedContent: Text(
                                "Popülerlik puanını etkileyen faktörleri görmek için TIKLAYIN!",
                                style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            expandedContent: Column(
                              children: [
                                ListTile(
                                  title: Text( "VIP üyelik satın almanız durumunda 1000 popülerlik puanı kazanırsınız.", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ),),
                                  trailing: Text( "+1000\nPuan", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueAccent,
                                  ),
                                    textAlign: TextAlign.center,),
                                  subtitle: Text( "VIP üyeliğinizi iptal etmeniz veya VIP üyelik sürenizin dolması durumunda verilen puan geri alınır. ", style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height / 50,),
                                ListTile(
                                  title: Text( "Müşteriye yapılan her satış işlemi için 10 popülerlik puanı kazanırsınız.", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ),),
                                  trailing: Text( "+10\nPuan", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueAccent,
                                  ),textAlign: TextAlign.center,),
                                  subtitle: Text( "Satış iptal edilirse puan geri alınır.", style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height / 50,),
                                ListTile(
                                  title: Text( "Mekanınız bir müşteri tarafından değerlendirildiğinde verilen 3 yıldız için 3, 4 yıldız için 4 ve 5 yıldız için 5 popülerlik puanı kazanırsınız.", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ),),
                                  trailing: Text( "+5\nPuan", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueAccent,
                                  ),textAlign: TextAlign.center,),
                                  subtitle: Text( "1 ve 2 yıldız verilen değerlendirmeler puanınızı etkilemez, değerlendirme geri alındığı takdirde verilen puanda geri alınır.", style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height / 50,),
                                ListTile(
                                  title: Text( "Mekanınız bir müşteri tarafından favoriye alındığında 2 popülerlik puanı kazanırsınız.", style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ),),
                                  trailing: Text( "+2\nPuan", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blueAccent,
                                  ),textAlign: TextAlign.center,),
                                  subtitle: Text( "Müşteri favori mekanlardan sizi çıkardığı durumda verilen puan geri alınır.", style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),),
                                ),
                              ],
                            )),
                        SizedBox(height: MediaQuery.of(context).size.height / 20,),
                        ListTile(
                          title: Text( "En Populer 100 Salon", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent,
                          ),),
                          trailing: Text( "Puan", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                          subtitle: Text( "Tüm Şehirler", style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),),
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 8),
                              ),
                              itemCount: corporationList == null ? 0 : corporationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                CorporationModel item = corporationList[index];
                                String subText = item.isPopularCorporation ? OrganizationItemsState.getRegionName(item.region)+" - VIP Üye" : OrganizationItemsState.getRegionName(item.region)+" - Normal Üye";
                                return ListTile(
                                  subtitle: Text(
                                    subText,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  title: Text( item.corporationName,),
                                  leading: Text((index+1).toString(), style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent,
                                  )),
                                  trailing: Text( item.point.toString(), style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent,
                                  ),),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 20,),
                        ListTile(
                          title: Text( "En Populer 100 Salon", style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                          trailing: Text( "Puan", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                          ),),
                          subtitle: Text( "Bulunduğun Şehir ("+OrganizationItemsState.getRegionName(corporationModel.region)+")", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),),
                        ),
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 8),
                              ),
                              itemCount: corporationListWithCity == null ? 0 : corporationListWithCity.length,
                              itemBuilder: (BuildContext context, int index) {
                                CorporationModel item = corporationListWithCity[index];
                                String subText = item.isPopularCorporation ? "VIP Üye" : "Normal Üye";
                                return ListTile(
                                  subtitle: Text(
                                    subText,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  title: Text( item.corporationName,),
                                  leading: Text((index+1).toString(), style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent,
                                  )),
                                  trailing: Text( item.point.toString(), style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.redAccent,
                                  ),),
                                );
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
