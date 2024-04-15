import 'package:codde_pi/app/pages/soon/soon.dart';
import 'package:flutter/material.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Soon(title: "Tools"),
    );
  }
}/*
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:codde_pi/src/model/device/device.dart';
import 'package:codde_pi/src/model/device/device_form.dart';
import 'package:codde_pi/src/model/device/device_info.dart';
import 'package:codde_pi/src/model/tools/menu_list.dart';
import 'package:codde_pi/src/model/tools/wide_appbar.dart';
import 'package:codde_pi/src/supplemental/backdrop.dart';
import 'package:codde_pi/src/supplemental/device_manager.dart';
import 'package:codde_pi/src/views/ui/test.dart';
import 'package:codde_pi/src/views/ui/tools/dashboard_tools.dart';
import 'package:codde_pi/src/views/ui/tools/widgets/responsive.dart';
import 'package:codde_pi/src/views/ui/tools/sftp.dart';
import 'package:codde_pi/src/views/ui/tools/ssh.dart';
import 'package:codde_pi/src/views/ui/tools/vnc.dart';
import 'package:codde_pi/src/views/ui/tools/xterm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tools extends StatefulWidget {
  Tools();

  @override
  _ToolsState createState() => _ToolsState();
}

typedef Navigating = void Function(String path);

class _ToolsState extends State<Tools> with TickerProviderStateMixin {

  static const double _minLeadingWidth = 48.0;
  static const int _timeout = 6;

  Device? _device;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String uid;

  late FocusNode detectDeviceFormFocus;
  late String _connectionStatus;
  late SharedPreferences prefs;
  late String? deviceCache;
  Ping? ping;

  //AD LISTENER
  late NativeAdListener _adListener = NativeAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      print('Ad loaded.');
      setState(() {
        _adLoaded = true;
        _adMessage = null;
      });
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      print('Ad failed to load from native ad: $error');
      setState(() {
        _adMessage = error.message*/
/* ?? 'Unexpected Error'*//*
;
        print('message => $_adMessage');
        _adLoaded = false;
      });
      ad.dispose();
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
    // Called when a click is recorded for a NativeAd.
    onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
  );
  late NativeAdListener _adListener2 = NativeAdListener(
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      print('Banner native => $error');
      if (_adMessage == null) _adMessage = error.message;
      ad.dispose();
    },
  );
  late NativeAdListener _adShapeListener = NativeAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      print('Ad Banner loaded.');
      setState(() {
        _adShapeLoaded = true;
        _adShapeMessage = null;
      });
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      //print('Ad failed to load: $error');
      setState(() {
        _adShapeMessage = error.message*/
/* ?? 'Unexpected Error'*//*
;
        _adShapeLoaded = false;
      });
      ad.dispose();
    },
  );
  late NativeAdListener _adShapeListener2 = NativeAdListener(
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      if (_adShapeMessage == null) _adShapeMessage = error.message;
      ad.dispose();
    },
  );

  // NATIVE AD
  late NativeAd _nativeAd = NativeAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110', //todo: debug 1 // ca-app-pub-1213034477223045/8801047691
    factoryId: 'tools_banner_short',
    request: AdRequest(),
    listener: _adListener,
    nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.topRightCorner,
    ),
  );
  late NativeAd _nativeAd2 = NativeAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110', //todo: debug 1 // ca-app-pub-3940256099942544/2247696110
    factoryId: 'tools_banner_short',
    request: AdRequest(),
    listener: _adListener2,
    nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.topRightCorner,
    ),
  );
  late NativeAd _adShape = NativeAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110', //todo: debug 1
    factoryId: 'tools_shape',
    request: AdRequest(),
    listener: _adShapeListener,
    nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.topRightCorner,
    )
  );
  late NativeAd _adShape2 = NativeAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110', //todo: debug 1 // ca-app-pub-1213034477223045/5282520806
    factoryId: 'tools_shape',
    request: AdRequest(),
    listener: _adShapeListener2,
    nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.topRightCorner,
    )
  );
  late DeviceInfo2 _deviceInfo = DeviceInfo2(
    selection: selectDeviceToConnect,
    edition: startEdition,
    */
/*uid: uid,*//*

    linearMode: !isPortraitMode,
    displayName: isPortraitMode,
    */
/*deviceID: deviceID,*//*

  );


  final GlobalKey<BackDropState> bdpKey = GlobalKey();
  final GlobalKey _keyKey = GlobalKey();
  final path = '/tools/dashboard';

  var _deviceEditMode = false;
  var deviceSelected;
  var deviceName = '';
  var pingError = '';
  int _currentIndex = 0;
  String? dropdownValue;
  List<String> dropdownList = [];
  var displayInfo = true;
  var _adLoaded = false;
  var _adShapeLoaded = false;
  String? _adMessage;
  String? _adShapeMessage;

  Size get screenSize => MediaQuery.of(context).size;
  get listWidth => screenSize.width / 3;
  get itemSelected => path;
  get frontLayerHeight => screenSize.height -
      kToolbarHeight -
      (MediaQuery.of(context).padding.top + 48.0*/
/* + appBar.preferredSize.height*//*
);

  bool get isPortraitMode => screenSize.height > screenSize.width;

  @override
  void initState() {
    super.initState();

    //UID
    if (auth.currentUser?.uid != null) {
      uid = auth.currentUser!.uid;
    } else {
      //Navigator.pushNamed(context, "/login");
      uid = 'Error'; //todo: faire mieux que ça
      //return;
    }

    // PING STATUS
    _connectionStatus = 'SEARCHING';
    deviceSelected = true;
    //print(_connectionStatus);

    _nativeAd.load();
    _adShape.load();
    // _nativeAd.nativeAdOptions?.adChoicesPlacement == AdChoicesPlacement.topRightCorner;

    // CACHE
    getCache() */
/*.then((value) => getDeviceList())*//*
;
    getDeviceName();

    // PING
    //todo: le ping plante si on insiste
    checkConnection(false);
  }

  @override
  void dispose() {
    //detectDeviceFormFocus.dispose();
    if (ping != null) ping!.stop();
    _nativeAd.dispose();
    _adShape.dispose();
    _nativeAd2.dispose();
    _adShape2.dispose();
    super.dispose();
  }

  Future<void> getDeviceName() async {
    // obtain shared preferences
    //print('loading cache : device name');
    prefs = await SharedPreferences.getInstance();
    deviceName = prefs.getString('device_name') ?? 'No device';
  }

  Future<SharedPreferences> getCache() async {
    prefs = await SharedPreferences.getInstance();
    deviceCache = prefs.getString('device_cache');
    _device = await DeviceSHT().getDevice();
    return prefs;
  }

  void _onTileTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void startEdition() {
    //_device = _deviceInfo.device;
    setState(() {
      _deviceEditMode = true;
    });
  }

  void selectDeviceToConnect(Device device) {
    */
/*FirebaseFirestore.instance
          .collection('users')
          .doc('userId')
          .collection('devices')
          .doc(deviceID)
          .get()
          .then((DocumentSnapshot doc) {
        if (doc.exists) {
          print('selectDeviceToConnect : Document exists on the database');

          deviceName = doc['name'];
          prefs.setString('device_cache', 'last');
          prefs.setString('device_cache', 'last');
          prefs.setString('device_name', deviceName);
          prefs.setString('device_user', doc['user']);
          prefs.setString('device_host', doc['host']);
          prefs.setString('device_pswd', doc['pswd']);
          prefs.setString('device_port', doc['port']);
        }
      }).then((value) => startConnection());*//*


    if (device.id != null) {
      deviceName = device.name;
      prefs.setString('device_cache', 'last');
      prefs.setString('device_name', deviceName);
      prefs.setString('device_user', device.user);
      prefs.setString('device_host', device.host);
      prefs.setString('device_pswd', device.pswd);
      prefs.setString('device_port', device.port);
      prefs.setString('device_id', device.id!);
      _device = device;
      setState(() {});
      startConnection();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Cannot select an empty device"),
      ));
    }
  }

  Future<void> validateModifications(Map<String, String> values) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final deviceID = prefs.getString('device_id');
    var finalMap = Map<String, String>();

    values.forEach((key, value) {
      final cacheValue = prefs.getString('device_$key');
      if (cacheValue == null || value != cacheValue) {
        if (value != '') {
          finalMap[key] = value;
          prefs.setString('device_$key', value.toString());
        }
      }
    });

    return users
        .doc(uid)
        .collection('devices')
        .doc(deviceID)
        .update(finalMap)
        .then((value) {
      //print("Device Updated");
      _deviceEditMode = false;
      deviceName = prefs.getString('device_name')!;
      setState(() {});
    }).catchError((error) => print("Failed to update device: $error"));
  }

  void cancelModifications() {
    setState(() {
      _deviceEditMode = false;
    });
  }

  void switchDevice(String deviceID) {
    setState(() {
      //print('before snapshot $deviceID');
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('devices')
          .doc(deviceID)
          .get()
          .then((DocumentSnapshot doc) {
        //print('SWITCH DEVICE : snapshot');
        if (doc.exists) {
          //print('Document exists on the database');

          deviceID = doc.id;
        }
      });
    });
  }

  void startConnection() {
    //print('modification du cache terminée !');
    //print('DEVICE NAME = ${prefs.getString('device_name')}');
  }

  void addDeviceState() {
    setState(() {});
  }

  Widget mainWidget(String path) {
    switch (path) {
      case "/tools/sftp":
        return Sftp();
      case "/tools/xterm":
        return Xterm();
      case "/tools/ssh":
        return Ssh();
      case "/tools/vnc":
        return Vnc();
      case "/tools/keyboard":
        return Ssh();
      default:
        return DashboardTools();
    }
  }

  Future<String> checkConnection([bool showMessage = true]) async {
    if (_connectionStatus != 'SEARCHING')
      setState(() {
        _connectionStatus = 'SEARCHING';
      });
    //print('new ping');
    final prefs = await SharedPreferences.getInstance();
    final host = prefs.getString('device_host') ?? 'undefined';
    if (!RegExp("^(?:[0-9]{1,3}\.){3}[0-9]{1,3}\$")
        .hasMatch(host)) {
      setState(() {
        _connectionStatus = 'FAILED';
      });
      if (showMessage)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).errorColor,
          content: Text('Connection failed. Select a device or create a new one.',
          ),
        ),
      );

      //_nativeAd.load();
      return _connectionStatus;
    }
    ping = Ping(host, timeout: _timeout);
    var _pingResponse = false;
    ping!.stream.listen((event) {
      //print('event => ' + event.toString());
      if (event != null) {
        if (event.response?.ip != null || event.summary?.received == 1) {
          ping!.stop();
          setState(() {
            _connectionStatus = 'SUCCESS';
          });
          if (!_pingResponse) {
            if (showMessage) snackBarMessage('Connected', Colors.green);
          }

          _pingResponse = true;
        } else {
          // pingError = event.error!.error.name;
          ping!.stop();
          setState(() {
            _connectionStatus = 'FAILED';
          });
          if (event.error != null) {
            if (showMessage)
              snackBarMessage('Unable to connect to $host', Theme.of(context).errorColor);
          }
        }
      }
    }).onError((error) {
      ping!.stop();
      setState(() {
        _connectionStatus = 'FAILED';
        if (showMessage) snackBarMessage('$error', Theme.of(context).errorColor);
      });
    });
    //ping.stop();

    //_nativeAd.load();
    return _connectionStatus;
    // yield ping.stream;
  }

  void snackBarMessage(String msg, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? Theme.of(context).colorScheme.secondary,
          content: Text(msg)
      )
    );
  }

  bool canWeGo() {
    if (deviceCache == null) {
      snackBarMessage('You must set a Device configuration as default', Theme.of(context).errorColor);
      return false;
    }

    return true;
  }

  void onSsh() {
    //ping.stop();
    if (canWeGo())
      Navigator.pushNamed(context, '/tools/ssh');
  }
  void onSftp() {
    //ping.stop();
    if (canWeGo())
      Navigator.pushNamed(context, '/tools/sftp');
  }
  void onDbd() {
    //ping.stop();
    if (canWeGo())
      Navigator.pushNamed(context, '/tools/dashboard_tools');
  }
  void onKbd() {
    //ping.stop();
    if (canWeGo())
      Navigator.pushNamed(context, '/tools/w_keyboard');
  }
  void onXterm() {
    //ping.stop();
    snackBarMessage('Available soon !');
    //print('go to xterm route');
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
    //if (canWeGo()) Navigator.pushNamed(context, '/tools/xterm');
  }
  void onVnc() {
    //ping.stop();
    if (canWeGo())
      Navigator.pushNamed(context, '/tools/vnc');
  }
  void onScanner() {
    //ping.stop();
    //if (canWeGo())
      Navigator.pushNamed(context, '/tools/ip_scanner');
  }

  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
        portrait: (context) {

          return BackDrop(
              */
/*key: _bdpKey,*//*

              backLayer: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder(
                    future: getCache(),
                    builder:
                        (context, AsyncSnapshot<SharedPreferences> snapshot) {
                      if (snapshot.hasError) {
                        //print('snapshot error when loading cache : ${snapshot.error}.');
                      }
                      if (snapshot.hasData) {
                        //uid = snapshot.data!.getString('uid')!;
                        //deviceID = prefs.getString('device_cache');
                        //print('deviceID $deviceCache');

                        return Column(
                          children: [
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'CONNECTION STATUS : ',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  (_connectionStatus),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _connectionStatus == 'SUCCESS'
                                          ? Colors.green
                                          : Theme.of(context).errorColor),
                                )
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              child: _deviceEditMode
                                  ? EditDevice(
                                      validating: validateModifications,
                                      canceling: cancelModifications,
                                      editMode: true,
                                      //detectFocus: detectDeviceFormFocus,
                                      device: Device(
                                        name: _device?.name ?? '',
                                        user: _device?.user ?? '',
                                        host: _device?.host ?? '',
                                        pswd: _device?.pswd ?? '',
                                        port: _device?.port ?? '',
                                      ),
                                    )
                                  : DeviceInfo2(
                                selection: selectDeviceToConnect,
                                edition: startEdition,
                                */
/*uid: uid,*//*

                                linearMode: !isPortraitMode,
                                displayName: isPortraitMode,
                                */
/*deviceID: deviceID,*//*

                              ),
                            ),
                          ],
                        );
                      }

                      return Center(
                          child: Container(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator()));
                    }),
              ),
              */
/*BackdropMenu(
        selectedItem: _currentIndex,
        onTileTap: _onTileTap,
        itemCount: 3,
      ),*//*

              appBarTitle: deviceName,
              appBarLeading:
                  isPortraitMode ? Icons.tune_rounded : null,
              actions: [],
              connectionStatus: _connectionStatus,
              reloadPing: checkConnection,
              gesture: screenSize.height >= (screenSize.width / 2) * 4,
              frontLayer: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: null,
                body: Container(
                  child: ResponsiveTools(
                        orientation: MediaQuery.of(context).size.shortestSide < 600 ? 'phone' : 'tablet',
                        onSsh: onSsh,
                        onSftp: onSftp,
                        onDbd: onDbd,
                        onKbd: onKbd,
                        onXterm: onXterm,
                        onVnc: onVnc,
                        onScanner: onScanner,
                        ad: _nativeAd,
                        adLoaded: _adLoaded,
                        adMessage: _adMessage,
                        adShape: _adShape,
                        adShapeLoaded: _adShapeLoaded,
                        adShapeMessage: _adShapeMessage,
                      )
                ),
              ),
              fab: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    DeviceManager(context).showNewDeviceDialog();
                  }),
        );},
        landscape: (context) {
          return Scaffold(
            appBar: WideAppBar(
              title: Text(deviceName),
              isOpen: displayInfo,
              onLeadingPressed: () =>
                  setState(() => displayInfo = !displayInfo),
              pingStatus: true,
              connectionStatus: _connectionStatus,
              reloadPing: checkConnection,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => DeviceManager(context).showNewDeviceDialog(),
                child: Icon(Icons.add)),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(
                  visible: displayInfo,
                  child: MenuListTools(
                    child: SingleChildScrollView(
                      child: Container(
                        child: _deviceEditMode
                            ? EditDevice(
                                validating: validateModifications,
                                canceling: cancelModifications,
                                editMode: true,
                                // detectFocus: detectDeviceFormFocus,
                                device: Device(
                                  name: _device?.name ?? '',
                                  user: _device?.user ?? '',
                                  host: _device?.host ?? '',
                                  pswd: '',
                                  port: _device?.port ?? '',
                                ),
                              )
                            : DeviceInfo2(
                          selection: selectDeviceToConnect,
                          edition: startEdition,
                          */
/*uid: uid,*//*

                          linearMode: !isPortraitMode,
                          displayName: isPortraitMode,
                          */
/*deviceID: deviceID,*//*

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),MediaQuery.of(context).size.shortestSide < 600 ?
                    Expanded(child:
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth < screenSize.width * 0.75) {
                        return ResponsiveTools(
                          orientation: 'phoneSemi'*/
/*screenSize.width < 900 ? 'phone' : 'phoneSemi'*//*
,
                          onSsh: onSsh,
                          onSftp: onSftp,
                          onDbd: onDbd,
                          onKbd: onKbd,
                          onXterm: onXterm,
                          onVnc: onVnc,
                          onScanner: onScanner,
                          ad: _nativeAd,
                          adLoaded: _adLoaded,
                          adMessage: _adMessage,
                          adShape: _adShape,
                          adShapeLoaded: _adShapeLoaded,
                          adShapeMessage: _adShapeMessage,
                          adShapeLandscape: _adShape2,
                          adBannerLandscape: _nativeAd2,
                        );
                      } else {
                        return ResponsiveTools(
                          orientation: 'phoneLandscape',
                          onSsh: onSsh,
                          onSftp: onSftp,
                          onDbd: onDbd,
                          onKbd: onKbd,
                          onXterm: onXterm,
                          onVnc: onVnc,
                          onScanner: onScanner,
                          ad: _nativeAd,
                          adLoaded: _adLoaded,
                          adMessage: _adMessage,
                          adShape: _adShape,
                          adShapeLoaded: _adShapeLoaded,
                          adShapeMessage: _adShapeMessage,
                        );
                      }
                    })
                    )
                    :
    Flexible(child: LayoutBuilder(builder: (context, constraints) {
    if (constraints.maxWidth < screenSize.width * 0.75) {
                return ResponsiveTools(
                  orientation: 'tabletSemi',
                  onSsh: onSsh,
                  onSftp: onSftp,
                  onDbd: onDbd,
                  onKbd: onKbd,
                  onXterm: onXterm,
                  onVnc: onVnc,
                  onScanner: onScanner,
                  ad: _nativeAd,
                  adLoaded: _adLoaded,
                  adMessage: _adMessage,
                  adShape: _adShape,
                  adShapeLoaded: _adShapeLoaded,
                  adShapeMessage: _adShapeMessage,
                  adShapeLandscape: _adShape2,
                  adBannerLandscape: _nativeAd2,
                );
    } else {
    return ResponsiveTools(
    orientation: 'tabletLandscape',
    onSsh: onSsh,
    onSftp: onSftp,
    onDbd: onDbd,
    onKbd: onKbd,
    onXterm: onXterm,
    onVnc: onVnc,
    onScanner: onScanner,
    ad: _nativeAd,
    adLoaded: _adLoaded,
    adMessage: _adMessage,
    adShape: _adShape,
    adShapeLoaded: _adShapeLoaded,
    adShapeMessage: _adShapeMessage,
    );
    }}),),
              ],
            ),
          );
        },
    );
  }
}
*/
