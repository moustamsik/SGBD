import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psgbd/SGBD.dart';

import 'HomePage.dart';

class Ajouter extends StatefulWidget {
  const Ajouter({super.key});

  @override
  State<Ajouter> createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  var sqlSGBD =SGBD();
  TextEditingController nom = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController q= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title: Text("Ajouter")),
    body: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  TextFormField(
                 controller: nom,
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
                 controller: prix,
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
                    
                  controller: q,
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
           String sql ="INSERT INTO smartphone(nom,prix,quantite) VALUES ('${nom.text}',${double.parse(prix.text)},${int.parse(q.text)})";
          int a = await sqlSGBD.InsertData(sql);
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
                    child: Center(child: Text("Ajouter",style: TextStyle(fontSize: 20,color: Colors.white),))
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