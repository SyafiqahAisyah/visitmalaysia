
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:visitmalaysia/destination.dart';
import 'package:visitmalaysia/destinationInfo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
 
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List destinationInfo;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curstate = "";
  String state;
  String titlecenter = "";
  /*  List<String> _dropDownState = [
    "Johor",
    "Kedah",
    "Kelantan",
    "Perak",
    "Selangor",
    "Melaka",
    "Negeri Sembilan",
    "Pahang",
    "Perlis",
    "Penang",
    "Sabah",
    "Sarawak",
    "Terengganu"   
  ];*/
 

  @override
  void initState() {
    super.initState();
    _loadDestination();
   
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.orangeAccent,
          appBar: AppBar(
             backgroundColor: Colors.deepOrange,
            title: Text(
              'Destination',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: _visible
                    ? new Icon(Icons.expand_more)
                    : new Icon(Icons.expand_less),
                onPressed: () {
                  setState(() {
                    if (_visible) {
                      _visible = false;
                    } else {
                      _visible = true;
                    }
                  });
                },
              ),
            ],
          ),
          body: Container(
            child: Column ( 
              crossAxisAlignment : CrossAxisAlignment.center,
              children: <Widget>[                                                                                                                                                          
                              Visibility(
                                  visible: _visible,
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      height: screenHeight / 12.5,
                                      margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(
                                              child: Container(
                                            height: 30,
                                            child: TextField(
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                                autofocus: false,
                                                controller: _prdController,
                                                decoration: InputDecoration(
                                                    icon: Icon(Icons.search),
                                                    border: OutlineInputBorder())),
                                          )),
                                          Flexible(
                                              child: Text(
                                                    "Search ",
                                                    style: TextStyle(color: Colors.black),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  )),
                              Text(curstate,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54)),
                              destinationInfo== null
                                  ? Flexible(
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                      titlecenter,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ))))
                                  : Expanded(
                                      child: 
                                      GridView.count(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              (screenWidth / screenHeight) / 0.8,
                                          children:
                                              List.generate(destinationInfo.length, (index) {
                                            return Container(
                                                child: Card(
                                                    color: Colors.orange[200],                                    
                                                    elevation: 10,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.0)
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () => _destinationInfo(index),                                           
                                                            child: Container(
                                                              height: screenHeight / 5.9,
                                                              width: screenWidth / 3.5,
                                                              child: ClipOval(
                                                                  child: CachedNetworkImage(
                                                                fit: BoxFit.fill,
                                                                imageUrl:
                                                                    "http://slumberjer.com/visitmalaysia/images/${destinationInfo[index]['imagename']}",
                                                                placeholder: (context, url) =>
                                                                    new CircularProgressIndicator(),
                                                                errorWidget:
                                                                    (context, url, error) =>
                                                                        new Icon(Icons.error),
                                                              )),
                                                            ),
                                                          ),
                                                          
                                                          Text(destinationInfo[index]['loc_name'],
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                  color: Colors.black)),
                                                          Text(            
                                                                destinationInfo[index]['state'],
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15,
                                                                color: Colors.black),
                                                          ),
                                                                                                                                                                                       
                                                        ],
                                                      ),
                                                    )
                                                    ),                                   
                                                    );
                                          }
                                          )
                                          )
                                          )                                                                           
                     ]
                      )
                      )        
    )
                      );
                }
              
                _destinationInfo(int index) async{
                  Destination destination = new Destination(
              
                      pid: destinationInfo[index]['pid'],
                      locName: destinationInfo[index]['loc_name'],
                      state: destinationInfo[index]['state'],
                      description: destinationInfo[index]['description'],
                      latitude: destinationInfo[index]['latitude'],
                      longitude: destinationInfo[index]['longitude'],
                      url: destinationInfo[index]['url'],
                      contact: destinationInfo[index]['contact'],
                      address: destinationInfo[index]['address'],
                      imagename: destinationInfo[index]['imagename']);
                     
                     Navigator.push(
                       context, 
                       MaterialPageRoute(
                         builder:(BuildContext context)  => DestinationInfo(destination: destination)
                         )
                       );
              
                }
              
               /* _onImageDisplay(int index) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          content: new Container(             
                            height: screenHeight / 2.2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    height: screenWidth / 1.5,
                                    width: screenWidth / 1.5,
                                    decoration: BoxDecoration(                        
                                        image: DecorationImage(
                                            fit: BoxFit.scaleDown,
                                            image: NetworkImage(
                                                "http://slumberjer.com/visitmalaysia/images/${destinationInfo[index]['imagename']}")))),
                              ],
                            ),
                          ));
                    },
                  );
                }*/
              
                void _loadDestination() {
                  
                  String urlLoadJobs = "http://slumberjer.com/visitmalaysia/load_destinations.php";
                  http.post(urlLoadJobs, body: {}).then((res) {
                    setState(() {
                      var extractdata = json.decode(res.body);
                       destinationInfo = extractdata  ['locations'];
                    });
                  }).catchError((err) {
                    print(err);
                  });
                }
              
              
              /*  _statelist (){
                  showDialog(
                    context: context,
                     builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(5.0))),
                              title: Text("State in Malaysia"),
                              
                        );
              
                     }
                    );
              
                }*/
              
                Future<bool> _onBackPressed() {
                  return showDialog(
                        context: context,
                        builder: (context) => new AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          title: new Text(
                            'Are you sure?',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          content: new Text(
                            'Do you want to exit this App',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                },
                                child: Text(
                                  "Exit",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )),
                          ],
                        ),
                      ) ??
                      false;
                }
              
 /*void _sortItem(String state) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
          "http://slumberjer.com/visitmalaysia/load_destinations.php";
      http.post(urlLoadJobs, body: {
        "state": state,
      }).then((res) {
        setState(() {
          curstate = state;
          var extractdata = json.decode(res.body);
          destinationInfo = extractdata["locations"];
          FocusScope.of(context).requestFocus(new FocusNode());
          pr.dismiss();
        });
      }).catchError((err) {
        print(err);
        pr.hide();
      });
      pr.hide();
    }catch (e){
      Toast.show('Error',context,
      duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
    }*/
}
