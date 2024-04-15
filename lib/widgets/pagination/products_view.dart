import 'package:davetcim/widgets/pagination/pageStatus.dart';
import 'package:davetcim/widgets/pagination/repository.dart';
import 'package:flutter/material.dart';

import '../../shared/models/corporation_model.dart';
import '../../shared/sessions/user_state.dart';
import '../app_bar/app_bar_view.dart';
import '../grid_product.dart';

PageStorageKey pageStorageKey = const PageStorageKey("pageStorageKey");
final PageStorageBucket pageStorageBucket = PageStorageBucket();

class ListviewPaginationView extends StatefulWidget {

  @override
  _ListviewPaginationViewState createState() => _ListviewPaginationViewState();
}

class _ListviewPaginationViewState extends State<ListviewPaginationView> {
  CorporationRepository corporateRepo = CorporationRepository();
  ScrollController scrollController;

  @override
  void initState() {
    createScrollController();
    corporateRepo.getInitialUsers();
    super.initState();
  }

  void createScrollController() {
    scrollController = ScrollController();
    scrollController?.addListener(loadMoreUsers);
  }

  Future<void> loadMoreUsers() async {
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent &&
        corporateRepo.pageStatus.value != PageStatus.newPageLoading) {
      await corporateRepo.loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(pageName: "Salonlar", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return ValueListenableBuilder<PageStatus>(
      valueListenable: corporateRepo.pageStatus,
      // ignore: missing_return
      builder: (context, PageStatus pageStatus, _) {
        switch (pageStatus) {
          case PageStatus.idle:
            return idleWidget();
          case PageStatus.firstPageLoading:
            return firstPageLoadingWidget();
          case PageStatus.firstPageError:
            return firstPageErrorWidget();
          case PageStatus.firstPageNoItemsFound:
            return firstPageNoItemsFoundWidget();
          case PageStatus.newPageLoaded:
          case PageStatus.firstPageLoaded:
            return firstPageLoadedWidget();
          case PageStatus.newPageLoading:
            return newPageLoadingWidget();
          case PageStatus.newPageError:
            return newPageErrorWidget();
          case PageStatus.newPageNoItemsFound:
            return newPageNoItemsFoundWidget();
        }
      },
    );
  }

  Widget listViewBuilder() {
    if (scrollController?.hasClients == true) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
    return PageStorage(
      key: pageStorageKey,
      bucket: pageStorageBucket,
      child: ListView.builder(
        controller: scrollController,
        itemCount: corporateRepo.corporates.length,
        itemBuilder: (context, index) {
          //var currentCorporate = corporateRepo.corporates[index];
          return GridView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.15),
            ),
            itemCount: corporateRepo.corporates == null
                ? 0
                : corporateRepo.corporates.length,
            itemBuilder: (BuildContext context, int index) {
              CorporationModel item = corporateRepo.corporates[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridProduct(
                    img: item.imageUrl,
                    isFav: UserState.isCorporationFavorite(item.corporationId),
                    name: item.corporationName,
                    rating: item.averageRating,
                    raters: item.ratingCount,
                    description: item.description,
                    corporationId: item.corporationId,
                    maxPopulation: item.maxPopulation
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget idleWidget() => const SizedBox();

  Widget firstPageLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget firstPageNoItemsFoundWidget() {
    return const Center(
      child: Text("İçerik bulunmadı"),
    );
  }

  Widget firstPageLoadedWidget() {
    return listViewBuilder();
  }

  Widget firstPageErrorWidget() {
    return const Center(
      child: Text("Hata oluştu"),
    );
  }

  Widget newPageLoadingWidget() {
    return Stack(
      children: [
        listViewBuilder(),
        bottomIndicator(),
      ],
    );
  }

  Widget newPageNoItemsFoundWidget() {
    return Column(
      children: [
        Expanded(
          child: listViewBuilder(),
        ),
        bottomMessage("İlave içerik bulunamadı")
      ],
    );
  }

  Widget newPageErrorWidget() {
    return Column(
      children: [
        Expanded(
          child: listViewBuilder(),
        ),
        bottomMessage("Yeni sayfa bulunamadı")
      ],
    );
  }

  Widget bottomIndicator() {
    return bottomWidget(
      child: const Padding(
        padding: EdgeInsets.all(18.0),
        child: LinearProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget bottomMessage(String message) {
    return bottomWidget(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(message),
      ),
    );
  }

  Widget bottomWidget({@required Widget child}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
}