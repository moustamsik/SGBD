import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:psgbd/SGBD.dart';

import 'Ajouter.dart';
import 'HomePage.dart';

class Modifier extends StatefulWidget {
  final id;
final nom;
final prix;
final q;
  Modifier({super.key,this.id,this.nom,this.prix,this.q});
  
  @override
  State<Modifier> createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  var sqlSGBD=SGBD();
  dynamic _idState;
  TextEditingController _nomState =TextEditingController();
  TextEditingController _prixState = TextEditingController();
  TextEditingController _qState = TextEditingController();
  @override
  void initState() {
    _idState=widget.id;
    _nomState.text=widget.nom;
    _prixState.text=widget.prix.toString();
    _qState.text = widget.q.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("Ajouter")),

   bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: "Home", 
         icon: IconButton(icon:Icon(Icons.home),onPressed:(){
            
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return HomePage();
          }));
         })),
        BottomNavigationBarItem(label:"Ajouter" ,
         icon: IconButton(icon:Icon(Icons.add),onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Ajouter();
          }));
         })),
      ]),


    body: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  TextFormField(
                 controller: _nomState,
                    decoration: InputDecoration(
                      
                      hintText: "Nom produit",
                      labelText: "Nom produit",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                          
                        )
                      )
                     ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                 controller: _prixState,
                    decoration: InputDecoration(
                      hintText: "Prix",
                      labelText: "Prix",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                          
                        )
                      )
                     ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    
                  controller:_qState,
                    decoration: InputDecoration(
                      hintText: "Quantité",
                      labelText: "Quantité",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                          
                        )
                      )
                     ),
                  ),
                  SizedBox(height: 20 ,),
                
                
                  MaterialButton(
                    onPressed: ()async{
                      
         try{
           String sql ="UPDATE 'smartphone' SET nom='${_nomState.text}' , prix=${double.parse(_prixState.text)}, quantite=${int.parse(_qState.text)} WHERE id= $_idState";
          int a = await sqlSGBD.updateData(sql);
          print(a);
          setState(() {
           Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return HomePage();
           }));
          });
         }catch(e){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Vous avez entrer des données non valide! "),
              actions: [
                MaterialButton(onPressed: (){
                  Navigator.of(context).pop();
                },child: Text("Ok"),)
              ],
            );
          });

         }
       
                  },
                  color: Colors.blueGrey,
                  child:Container(
                    width: double.infinity,
                    child: Center(child: Text("Modifier",style: TextStyle(fontSize: 20,color: Colors.white),))
                    ) ,
                  )
                ],
              ),
            ),
          ),
        ),
    )
    );
  }
}