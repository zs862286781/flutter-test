import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/battery');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('任务中心'),elevation: 0,),
      body: RefreshIndicator(
        onRefresh: () async {
        },
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context,index) {
            return GestureDetector(
              onTap: () async {
                try {
//                  final Map result = await methodChannel.invokeMethod('getLocation');
//                  print(result['formattedAddress']);
                  await methodChannel.invokeMethod('goMap');
                } on PlatformException {
                }
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 99,
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: Text('技',style: TextStyle(fontSize: 30,color: Colors.white),),
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('技术室副主任审核',style: TextStyle(fontSize: 16),),
                              ),
                              Text('待处理数量：1',style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 100, 100, 1)))
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Color.fromRGBO(245, 245, 245, 1),
                    )

                  ],
                ),
              ),
            );
          },
          itemCount: 6,
          itemExtent: 100,
        ),
      ),
    );
  }
}