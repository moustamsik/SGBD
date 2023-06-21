import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psgbd/Modifier.dart';
import 'Ajouter.dart';
import 'SGBD.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sqlSGBD= SGBD();
 
  Future<List<Map>> getAllphone() async{
String sql ="SELECT * FROM 'smartphone'";
 List<Map> listePone = await sqlSGBD.getData(sql);
return listePone;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:AppBar(
        title: Text("All Products"),
      ) ,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: "Home", 
         icon: IconButton(icon:Icon(Icons.home),onPressed:(){

        
         })),
        BottomNavigationBarItem(label:"Ajouter" ,
         icon: IconButton(icon:Icon(Icons.add),onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Ajouter();
          }));
         })),
      ]),
      body: Container(
        margin: EdgeInsets.all(15),
        child: FutureBuilder(
          future: getAllphone(),
         builder:(context,sanpshot){
          if (sanpshot.hasData){
            List<Map> L=sanpshot.data!;
            return ListView.builder(
              
              itemCount: L.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text("${L[index]['nom']}"),
                    subtitle: Text("${L[index]['quantite']}"),
                    trailing: Container(
                      width: 100,
                      child: Row(children: [
                      IconButton(onPressed: ()async{
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Vouez vous suprime cette element"),
                              actions: [
                                MaterialButton(onPressed: ()async{
                                  String sql="DELETE FROM 'smartphone' WHERE id=${L[index]['id']}";
                                  int a =await sqlSGBD.deletData(sql);
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },child:Text("ok")),
                                MaterialButton(onPressed: (){
                                    setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },child:Text("Annuler")),
                                
                              ],
                            );
                          });
                      }, 
                      icon: Icon(Icons.delete),color: Colors.red,),
                      IconButton(onPressed: (){
                        ///////
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return Modifier(id:L[index]['id'] ,nom: L[index]['nom'],prix: L[index]['prix'],q: L[index]['quantite'],);
                        }));
                        ////////
                      }, icon: Icon(Icons.edit),color: Colors.green,),
                    ],),),
                  ),
                );
              });
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
          
         }
    
          ),
      ),
      
      )
      
      
      );
  }
}