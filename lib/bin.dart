import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:molex_mob/location.dart';
import 'package:molex_mob/models/bundle_bun.dart';

class Bin extends StatefulWidget {
  @override
  String userId;
  String machineId;
  Bin({this.userId, this.machineId});
  _BinState createState() => _BinState();
}

class _BinState extends State<Bin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _bundleController = new TextEditingController();
  TextEditingController _binController = new TextEditingController();
  FocusNode _bundleFocus = new FocusNode();
  List<Bundle> bundleList = [];
  String binId;
  String bundleId;
  bool hasBin = false;
  String binState;
  @override
  void initState() {
      SystemChrome.setEnabledSystemUIOverlays([]);
    binState = "Scan Bin";
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  void checkBin(String bin) {
    setState(() {
      if (bin?.length == 10) {
        hasBin = true;
        binState = "Scan Next bin";
        _bundleFocus.requestFocus();
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _binController.dispose();
    _bundleController.dispose();
    _bundleFocus.dispose();
    super.dispose();
  }

  void checkBundle(String bundle) {
    setState(() {
      if (bundle?.length == 10) {
        hasBin = true;
        bundleList.add(Bundle(
          binId: binId,
          bundleId: bundle,
        ));
        print(bundleList);
        _bundleController.clear();
        bundleId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkBin(binId);
    checkBundle(bundleId);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Bundle Transfer',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.schedule,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            "Shift A",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            height: 40,
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            widget.userId,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.settings,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            widget.machineId ?? "",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MM-dd-yyyy').format(DateTime.now()),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      DateFormat('hh:mm').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent[100],
                      offset: const Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //Bo
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/image/profile.jpg',
                      ),
                      fit: BoxFit.fill)),
            ),
          )
        ],
      ),

      // AppBar(
      //   backgroundColor: Colors.red[400],
      //   title: const Text('Bundle Transfer'),
      //   backwardsCompatibility: true,
      //   actions: [
      //     Container(
      //       height: 40,
      //       width: 150,
      //       child: Column(
      //         children: [
      //           SizedBox(height: 5),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Text(
      //                 "User Id",
      //                 style: TextStyle(color: Colors.grey[100]),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Text(
      //                 "12210",
      //                 style:
      //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Container(
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.all(Radius.circular(100)),
      //             image: DecorationImage(
      //                 image: AssetImage(
      //                   'assets/image/profile.jpg',
      //                 ),
      //                 fit: BoxFit.fill)),
      //       ),
      //     )
      //   ],
      // ),

      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: RawKeyboardListener(
                              focusNode: FocusNode(),
                              onKey: (event) => handleKey(event.data),
                              child: TextField(
                                  autofocus: true,
                                  controller: _binController,
                                  onTap: () {
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                    if (binState == "Scan Next bin") {
                                      _binController.clear();
                                      setState(() {
                                        binId = null;
                                        binState = "Scan Bin";
                                      });
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      binId = value;
                                    });
                                  },
                                  decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[400],
                                            width: 2.0),
                                      ),
                                      hintText: 'Scan bin',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5.0))),
                            ),
                          ),
                        ),
                        //Scan Bin Button
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white,
                            ),
                            child: Text(
                              binState,
                            ),
                            onPressed: () {},
                          )),
                        ),
                      ],
                    ),

                    //sCAN bUNDLE bUTTON
                    (() {
                      if (hasBin) {
                        return Container(
                          child: Row(
                            children: [
                              Container(
                                width: 250,
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    onKey: (event) => handleKey(event.data),
                                    child: TextField(
                                        focusNode: _bundleFocus,
                                        controller: _bundleController,
                                        onTap: () {
                                          SystemChannels.textInput
                                              .invokeMethod('TextInput.hide');
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            bundleId = value;
                                          });
                                        },
                                        decoration: new InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 2.0),
                                            ),
                                            hintText: 'Scan bin',
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 5.0))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red, // background
                                    onPrimary: Colors.white,
                                  ),
                                  child: Text(
                                    'Scan Bundle',
                                  ),
                                  onPressed: () {},
                                )),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }()),
                    (() {
                      if (bundleList.length > 0) {
                        return Row(
                          children: [
                            Container(
                                width: 300,
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green, // background
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _bundleFocus.unfocus();
                                            _binController.clear();
                                            binId = null;
                                          });

                                          // _bundleFocus.unfocus();
                                          _showConfirmationDialog();
                                          // Future.delayed(
                                          //   const Duration(milliseconds: 50),
                                          //   () {
                                          //     Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           Location()),
                                          // );
                                          //   },
                                          // );
                                          //
                                        },
                                        child: Text('Transfer Bundles'),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }())
                  ],
                ),
              ),
              SizedBox(height: 10),
              dataTable(),
            ]),
      ),
    );
  }

  Widget dataTable() {
    int a = 1;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('No.'),
                ),
                DataColumn(
                  label: Text('Bin Id'),
                ),
                DataColumn(
                  label: Text('Bundle Id'),
                ),
                DataColumn(
                  label: Text('Remove'),
                ),
              ],
              rows: bundleList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text("${a++}")),
                      DataCell(Text(e.binId)),
                      DataCell(Text(e.bundleId)),
                      DataCell(IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            bundleList.remove(e);
                          });
                        },
                      )),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");

    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Future<void> _showConfirmationDialog() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    return showDialog<void>(
      context: _scaffoldKey.currentContext,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Transfer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                  );
                },
                child: Text('Cancel Transfer')),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green),
                ),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Location(
                              userId: widget.userId,
                              machineId: widget.machineId,
                            )),
                  );
                },
                child: Text('Confirm Transfer')),
          ],
        );
      },
    );
  }
}
