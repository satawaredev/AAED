import 'package:flutter/material.dart';
import '../FAQ/treenodes.dart';


class FAQ1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

       /* body: TreeView(
          data: treeData,
          titleOnTap: () {
            print('title');
          },
          leadingOnTap: () {
            print('leading');
          },
          trailingOnTap: () {
            print('trailing');
          },
        ),*/

         body:SingleChildScrollView(child:Column(children:[
           SizedBox(height: 10,),
           TreeNodes(
           title: Text('What is Sensoryscape App ?',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight:FontWeight.bold),),
          children: [
            SizedBox(height: 5,),
            TreeNodes(
               title: Text('Sensoryscope app is very used bghgu uyguqhmkbg g uyb 8ujop ',style: TextStyle(fontSize: 18,color: Colors.black,),),

      ),],),
           SizedBox(height: 15,),
           TreeNodes(
             title: Text('How does it work?',style: TextStyle(fontSize: 21,color: Colors.black,fontWeight:FontWeight.bold),),
             children: [
               SizedBox(height: 5,),
               TreeNodes(
                 title: Text('Sensoryscope app is very used bghgu uyguqhmkbg g uyb 8ujop',style: TextStyle(fontSize: 18,color: Colors.black,),),

               ),],),
           SizedBox(height: 15,),

          ],),),);
  }
}