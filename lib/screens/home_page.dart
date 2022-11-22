import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:sim_data/sim_data.dart' as sim;

import '../app_theme.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../screens/screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController.index;
      print(currentTabIndex);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String _mobileNumber = (await MobileNumber.mobileNumber)!;
      var _simCard = (await MobileNumber.getSimCards)!;

      print('-----Number> $_mobileNumber');
      for(SimCard s in _simCard) {

        print('==========> ${s.toMap()}');

      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {});
  }


  @override
  void dispose() {
    tabController.addListener(() {
      onTabChange();
    });

    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    initMobileNumberState();
    try {
      sim.SimDataPlugin.getSimData().then((simData) {
        for (var s in simData.cards) {
          print('------------1> ${s.carrierName}');
          print('------------2> ${s.countryCode}');
          print('------------3> ${s.displayName}');
          print('------------4> ${s.isDataRoaming}');
          print('------------5> ${s.isNetworkRoaming}');
          print('------------6> ${s.mcc}');
          print('------------7> ${s.mnc}');
          print('------------8> ${s.serialNumber}');
          print('------------9> ${s.slotIndex}');
          print('------------0> ${s.subscriptionId}');
        }
      });

    } on PlatformException catch (e) {
      debugPrint("error! code: ${e.code} - message: ${e.message}");
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.kPrimaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(
          'Chattie',
          style: MyTheme.kAppTitle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {},
          )
        ],
        elevation: 0,
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: Column(
        children: [
          MyTabBar(tabController: tabController),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: TabBarView(
                controller: tabController,
                children: const [
                  ChatPage(),
                  Center(child: Text('Status')),
                  Center(child: Text('Call')),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          currentTabIndex == 0
              ? Icons.message_outlined
              : currentTabIndex == 1
                  ? Icons.camera_alt
                  : Icons.call,
          color: Colors.white,
        ),
      ),
    );
  }
}
