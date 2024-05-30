import 'package:davetcim/shared/helpers/customer_helper.dart';
import 'package:davetcim/src/admin_corporate_panel/other_user_reservation/register_new_user_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/models/customer_model.dart';
import '../../../shared/sessions/other_user_state.dart';
import '../../../shared/utils/utils.dart';
import '../../../widgets/app_bar/app_bar_view.dart';
import '../../../widgets/indicator.dart';
import 'calendar_new_user_view.dart';


class SearchUserBox extends StatefulWidget {

  @override
  State<SearchUserBox> createState() => _SearchUserBoxState();
}

class _SearchUserBoxState extends State<SearchUserBox> {
  bool _isOpened = false;
  bool _isSearching = false;
  bool hasDataTaken = false;
  final TextEditingController _controller = TextEditingController();
  List<CustomerModel> activeCustomerList =[];

  void getAllActiveCustomers() async{
    CustomerHelper customerHelper = new CustomerHelper();
    activeCustomerList = await customerHelper.getActiveCustomers();
    setState(() {
      activeCustomerList = activeCustomerList;
      activeCustomerList.sort((a, b) => a.name.compareTo(b.name));
      hasDataTaken = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllActiveCustomers();
  }

  List<String> _search(String value) {
    List<String> searchList = [];
    for (int i = 0; i < activeCustomerList.length; i++) {
      String name = activeCustomerList[i].name + ' ' + activeCustomerList[i].surname;
      if (name.toLowerCase().contains(value.toLowerCase())) {
        searchList.add(name);
      }
    }
    return searchList;
  }

  List<CustomerModel> customerSearch(String value) {
    List<CustomerModel> searchList = [];
    for (int i = 0; i < activeCustomerList.length; i++) {
      String name = activeCustomerList[i].name + ' ' + activeCustomerList[i].surname;
      if (name.toLowerCase().contains(value.toLowerCase())) {
        searchList.add(activeCustomerList[i]);
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    if (!hasDataTaken) {
      return Scaffold(appBar:
      AppBarMenu(pageName: "Kullanıcı Seçimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
          body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Center(child: Indicator())));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.navigateToPage(context, RegisterNewUserView());
        },
        label: Text('Yeni Kullanıcı Oluştur', style: TextStyle(fontSize: 15), maxLines: 2),
        icon: Icon(Icons.add_circle),
        backgroundColor: Colors.redAccent,
      ),

      appBar: AppBarMenu(pageName: "Kullanıcı Seçimi", isHomnePageIconVisible: true, isNotificationsIconVisible: true, isPopUpMenuActive: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          height: _isOpened ? MediaQuery.of(context).size.height * 0.8  : MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black45,
                Colors.deepOrangeAccent.shade700.withRed(200),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isOpened = !_isOpened;
                      });
                    },
                    child: TextFormField(
                      controller: _controller,
                      enabled: _isOpened ? true : false,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _isOpened = true;
                          });
                        } else {
                          setState(() {
                            _isOpened = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Müşteri Ara...",
                        hintStyle: TextStyle(color: Colors.white12, fontSize: 18),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: AnimatedOpacity(
                          duration: const Duration(milliseconds: 700),
                          opacity: _isOpened ? 0 : 1,
                          child: const Icon(
                            Icons.search,
                            color: Colors.white70,
                            size: 32,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: _isSearching
                              ? AnimatedOpacity(
                              duration: const Duration(milliseconds: 700),
                              opacity: _isOpened ? 0 : 1,
                              child: Transform.scale(
                                scale: 0.4,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white70),
                                ),
                              ))
                              : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_controller.text.isNotEmpty)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller.clear();
                                      _isOpened = !_isOpened;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              const SizedBox(width: 10.0),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.white24,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.filter_list,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          _isSearching = true;
                          _isOpened = false;
                        });
                      },
                    ),
                  ),
                ),
                if (_isOpened)
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7 ,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _search(_controller.text).length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                CustomerModel customerModel = customerSearch(_controller.text)[index];
                                OtherUserState.setFromCustomer(customerModel);
                                Utils.navigateToPage(context, CalendarNewUserScreen());
                              },
                              title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 700),
                                opacity: _controller.text ==
                                    _search(_controller.text)[index]
                                    ? 1
                                    : 0.5,
                                child: Text(
                                  _controller.text ==
                                      _search(_controller.text)[index]
                                      ? _search(_controller.text)[index]
                                      : _search(_controller.text)[index],
                                  style: TextStyle(
                                    color: _controller.text ==
                                        _search(_controller.text)[index]
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              leading: AnimatedOpacity(
                                duration: const Duration(milliseconds: 700),
                                opacity: _controller.text ==
                                    _search(_controller.text)[index]
                                    ? 1
                                    : 0.5,
                                child: Icon(
                                  Icons.search,
                                  color: _controller.text ==
                                      _search(_controller.text)[index]
                                      ? Colors.white
                                      : Colors.white70,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}