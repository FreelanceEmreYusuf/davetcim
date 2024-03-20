import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/models/organization_type_model.dart';
import '../shared/models/region_model.dart';
import '../shared/sessions/application_cache.dart';
import '../src/search/search_view_model.dart';

class SoftFilterWidget extends StatefulWidget {
  @override
  State<SoftFilterWidget> createState() => _SoftFilterWidgetState();
}

class _SoftFilterWidgetState extends State<SoftFilterWidget> {
  List<RegionModel> regionList = ApplicationCache.filterCache.regionModelList;
  List<OrganizationTypeModel> organizationTypeList =
      ApplicationCache.filterCache.organizationTypeList;

  int _selectedRegion = 0;
  int _selectedDistrict = 0;
  int _selectedOrganizationIndex = 0;

  @override
  void initState() {
    super.initState();
    _firstInitialDistrict();
  }

  void _firstInitialDistrict() async {
    if (regionList != null && regionList.length > 0) {
      SearchViewModel rm = SearchViewModel();
      districtList = await rm.fillDistrictlist(regionList[0].id);
    } else {
      _firstInitialDistrict();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/soft_filter_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3), // Arka planın opaklığı
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFilterCard(
                    "Mekan Türü",
                    organizationTypeList[_selectedOrganizationIndex].name,
                    onTap: () => _showOrganizationTypePicker(context),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildFilterCard(
                          "İl",
                          regionList[_selectedRegion].name,
                          onTap: () => _showRegionPicker(context),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Expanded(
                        child: _buildFilterCard(
                          "İlçe",
                          districtList[_selectedDistrict].name,
                          onTap: () => _showDistrictPicker(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => _search(),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        'ARA',
                        style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCard(String title, String value, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrganizationTypePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                _selectedOrganizationIndex = index;
              });
            },
            children: organizationTypeList
                .map((type) => Center(child: Text(type.name)))
                .toList(),
          ),
        );
      },
    );
  }

  void _showRegionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) async {
              SearchViewModel rm = SearchViewModel();
              districtList = await rm.fillDistrictlist(regionList[index].id);
              setState(() {
                _selectedRegion = index;
                _selectedDistrict = 0;
              });
            },
            children: regionList
                .map((region) => Center(child: Text(region.name)))
                .toList(),
          ),
        );
      },
    );
  }

  void _showDistrictPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                _selectedDistrict = index;
              });
            },
            children: districtList
                .map((district) => Center(child: Text(district.name)))
                .toList(),
          ),
        );
      },
    );
  }

  void _search() {
    SearchViewModel rm = SearchViewModel();
    rm.goToFilterPageFromSoftFilter(
      context,
      regionList[_selectedRegion].id.toString(),
      districtList[_selectedDistrict].id.toString(),
      organizationTypeList[_selectedOrganizationIndex].id.toString(),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Sol alt köşe
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50); // Alt kenar
    path.lineTo(size.width, 0); // Sağ alt köşe
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
