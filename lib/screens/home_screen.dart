import 'package:flutter_web/material.dart';

import 'dart:html';
import 'dart:convert' as convert;
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:philips_remote/jointspace.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _HomeScreenState createState() => _HomeScreenState(this.title);
}

class _HomeScreenState extends State<HomeScreen> {

  _HomeScreenState(this.title);

  String tvProtocol = 'http';
  String tvIP = '192.168.0.50';
  String tvPort = '1925';
  String ApiVersion = '1';
  String inputKey = 'input/key';

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Philips Remote'),
        centerTitle: true,        
      ),
      body: _body(),
    );
  }

 
 ///
 ///Widgets
 ///
  Widget _body() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.power_settings_new),
                onPressed: () {
                  this._inputKey(Jointspace.inputStandby);
                }
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                  
              IconButton(
                icon: Icon(Icons.public),
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputOnline);
                },                    
              ),
              IconButton(
                icon: Icon(Icons.home),
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputHome);
                },                    
              ),
              IconButton(
                icon: Icon(Icons.live_tv),
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputWatchTV);
                },                    
              )
            ],
          ),        
          //_cursorControls(),
          _cursorFrame(),
          _colorButtons(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[                
              _volumeControls(),
              IconButton(
                icon: Icon(Icons.volume_off),
                padding: EdgeInsets.all(40.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputMute);
                },                    
              ),
              _channelControls()
            ]
          )              
          
        ],
      ),
    );
  }

  Widget _colorButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonBar(          
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 40.0,
                height: 20.0,
                child: RaisedButton(
                  color: Colors.red,
                  onPressed: () {},
                )
              ),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 40.0,
                height: 20.0,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () {},
                )
              )
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 40.0,
                height: 20.0,
                child: RaisedButton(
                  color: Colors.yellow,
                  onPressed: () {},
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: 40.0,
                height: 20.0,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                )
              )
            )
          ],
        ) 
      ],
    );
  }

  Widget _cursorFrame() {
    return Container(      
      width: 220.0,
      height: 180.0,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0,style: BorderStyle.solid,  color: Colors.white)
      ),
      child: _cursorControls(),
    );
  }

  Widget _cursorControls() {
    return Container(
      //width: 50.0,
      //height: 50.0,
      //padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[500],
        shape: BoxShape.circle,
        border: Border.all(width: 1.0,style: BorderStyle.solid,  color: Colors.grey[600])
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[          
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                  
              IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                iconSize: 30.0,
                color: Colors.grey[800],
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputCursorUp);
                },                    
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                  
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                iconSize: 30.0,
                color: Colors.grey[800],
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputCursorLeft);
                },                    
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0,style: BorderStyle.solid,  color: Colors.grey[600])
                ),
                child:IconButton(
                  icon: Icon(Icons.done),
                  iconSize: 32.0,
                  color: Colors.grey[800],
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    this._inputKey(Jointspace.inputConfirm);
                  },                    
                ),
              ),
              
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 30.0,
                color: Colors.grey[800],
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputCursorRight);
                },                    
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[                  
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 30.0,
                color: Colors.grey[800],
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  this._inputKey(Jointspace.inputCursorDown);
                },                    
              )
            ],
          ),

        ],
      ),
    );
  }

  Widget _volumeControls() {
    return Container(      
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
           SizedBox(
            width: 60.0,
            height: 50.0,
            child: FlatButton(             
              child: Icon(Icons.volume_up),
              onPressed: () async {                                               
                this._inputKey(Jointspace.inputVolumeUp);              
              },
            )
          ),
          Divider(
              height: 20.0,
          ),
          SizedBox(
            width: 60.0,
            height: 50.0,
            child: FlatButton(                        
              child: Icon(Icons.volume_down),            
                onPressed: () async {                                               
                  this._inputKey(Jointspace.inputVolumeDown);
                },
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _channelControls() {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 10.0),
      //margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
           SizedBox(
            width: 60.0,
            height: 50.0,
            child: FlatButton(             
              child: Icon(Icons.expand_less),
              onPressed: () async {                                               
                this._inputKey(Jointspace.inputChannelStepUp);              
              },
            )
          ),
          Divider(
            height: 20.0,
          ),
          SizedBox(
            width: 60.0,
            height: 50.0,
            child: FlatButton(          
              child: Icon(Icons.expand_more),            
                onPressed: () async {                                               
                  this._inputKey(Jointspace.inputChannelStepDown);              
                },
            ),
          ),
          
        ],
      ),
    );
  }
  ///
  /// End Widgets
  ///
  
  void _inputKey(String key) async {
    final url = "${this._getTvAPI()}/${inputKey}";

    Map data = {
      "key": key
    };

    var body = convert.jsonEncode(data);

    var response = await http.post(url, 
      // headers: {"Content-Type": "application/json"},
      body: body
    );

  }

  String _getTvAPI() {
    return "${tvProtocol}://${tvIP}:${tvPort}/${ApiVersion}";
  }
  
}