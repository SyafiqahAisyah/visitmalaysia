import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:visitmalaysia/destination.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationInfo extends StatefulWidget {
  final Destination destination;
  const DestinationInfo ({Key key, this.destination}) : super(key: key);
  @override
  _DestinationInfoState createState() => _DestinationInfoState();
}

class _DestinationInfoState extends State<DestinationInfo> {
   double screenHeight, screenWidth;
   @override
    void initState() {
    super.initState();
    
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _onBackPressed,
         child: Scaffold(
           backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Destination Info'),
        ),
        body: Container(   
          alignment: Alignment.topCenter,     
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Container(
                    height: screenHeight / 2,                   
                    child: CachedNetworkImage(
                      
                      fit: BoxFit.cover,
                      imageUrl:
                      "http://slumberjer.com/visitmalaysia/images/${widget.destination.imagename}"

                    ),
                  
              ),
              Padding(
                padding:const EdgeInsets.all(3),
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('LOCATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    )
                    ))

                  ],
                   rows: [

                      DataRow(cells: [
                        DataCell(Text(widget.destination.locName,
                        style: TextStyle(
                        fontSize: 15,
                        )
                        ))
                      ]
                      ),
                                           
                      DataRow(cells: [
                        DataCell(Text('DESCRIPTION',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,)
                        )
                          )
                      ]),
                                                            
                      DataRow(cells: [
                        DataCell(Text(widget.destination.description ,
                        style: TextStyle(
                        fontSize: 15,  
                        color: Colors.black
                        )
                        ))
                      ]
                      ),
                     
                      DataRow(cells: [
                        DataCell(Text('URL',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,)
                        )
                        )
                      ]),
                       
                        DataRow(cells: [
                        DataCell(GestureDetector(

                          onTap:() => _goToUrl,  
                          child: Text(widget.destination.url,
                          style: TextStyle(
                          fontSize: 15,
                           color: Colors.black  
                                                  )
                                                  )))
                                                ]
                                                ),
                                            
                                                DataRow(cells: [
                                                  DataCell(Text('ADDRESS',
                                                  style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,)
                                                  )
                                                  )
                                                ]),
                                            
                                                DataRow(cells: [
                                                  DataCell(Text(widget.destination.address,
                                                  style: TextStyle(
                                                  fontSize: 15,  
                                                  )
                                                  ))
                                                ]
                                                ),
                                            
                                                DataRow(cells: [
                                                  DataCell(Text('CONTACT',
                                                  style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,)
                                                  )
                                                  )
                                                ]),
                                            
                                                 DataRow(cells: [
                                                  DataCell(Text(widget.destination.contact,
                                                  style: TextStyle(
                                                  fontSize: 15,  
                                                  )
                                                  ))
                                                ]
                                                ),
                                            
                                             ]),)
                                        
                                      
                                      
                                        ],)
                                      )
                                   
                                  ),
                                
                                ),
                              ));
                            }
 _goToUrl(String text) async {
  if(text == widget.destination.url) {
   if(await canLaunch(text)) {
     await launch(text);
   }else{
     throw 'Could not launch $text';
   }}
   
  }

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
                                        'Back to homepage',
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
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            )),
                                        MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ) ??
                                  false;
                            }
}  
