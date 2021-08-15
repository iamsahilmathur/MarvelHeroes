import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvels/model_notifier.dart';
import 'package:marvels/states.dart';
import 'package:provider/provider.dart';

import 'model.dart';

void main() {
  runApp(
      ChangeNotifierProvider<MyNotifier>(
        create: (context) => MyNotifier(),
        child: MyApp(),
      ));
}

// Flutter Wrap widget used to wrap contents it will take size according to content

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Marvels"),
            centerTitle: true,
          ),
          body: FutureBuilder<List<Marvel>>(
            future: Provider.of<MyNotifier>(context).fetchList(),
            builder: (context,snapshot){
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return MGridView(heroList: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
      ),
    );
  }
}

class MGridView extends StatelessWidget {

  List<Marvel> heroList;

  MGridView({required this.heroList});

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: size.width/ (size.height *  .75),
        children: List.generate(heroList.length, (index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: 6,child: ClipRRect(borderRadius: BorderRadius.circular(4),child: Image.asset(heroList[index].profileImage,fit: BoxFit.cover,))),
                Wrap(
                  children: [
                    Align(alignment: Alignment.topLeft,child: Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),child: Text(heroList[index].name,style: TextStyle(fontSize: 15,color: Colors.blue,fontWeight: FontWeight.bold),)),),
                    Align(alignment: Alignment.topLeft,child: Padding( padding: EdgeInsets.symmetric(vertical: 2,horizontal:10),
                    child: Text("How got powers ?",style: TextStyle(fontSize: 13,color: Colors.blue,fontWeight: FontWeight.bold),)),),
                    Align(alignment: Alignment.topLeft,child: Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),child: Text(heroList[index].howGotPow,style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w100),))),
                    Align(alignment: Alignment.topLeft,child: Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),child: Text("Weapons",style: TextStyle(fontSize: 13,color: Colors.blue,fontWeight: FontWeight.bold),)),),
                    Align(alignment : Alignment.topLeft,child: Padding(padding: EdgeInsets.only(left: 10, right: 10,bottom: 8,top: 4),child: Text(heroList[index].weapons,style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w100),),)),
                  ],
                ),
              ],
            ),
          ),
        )),
    );
  }
}




