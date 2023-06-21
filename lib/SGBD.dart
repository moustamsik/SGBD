import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SGBD {
    // le ? veut dire que la base de donnée peut etre null vue que le 1ere fois qu'on lance l'appli il y a pas de db
static Database? _db;

Future<Database?> get db async{
  if (_db == null){
    print("db non trouver");

    _db = await initialisation() ;
     print("db initialiser");
    
     return _db;
  }
  else{return _db;}
  


}
Future<Database> initialisation() async{
    // Récupérer le chemin de la base de donneées du Smart ou bien Tablette 
 String Path_db = await getDatabasesPath();
 //Créer le chemin complet (Joindre le db_path avec le nom de la base de donée c'est pour cela qu'on imprt path.dart )
 String path = join(Path_db,"Phones");
  //La methode _createDB permet de créer les tables
 Database mydb =await openDatabase(path,onCreate: (db, version) {_createDB(db, version);} ,version: 1);
 print("fait");
return mydb;
}

   _createDB(Database db,int version) async {
      await db.execute('''
CREATE TABLE "smartphone" 
(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nom" TEXT NOT NULL,
    "prix" DECIMAL(13, 2) NOT NULL,
    "quantite" INT NOT NULL
  )

''');

print("===============TABLE CREATED====================");


}


//------------------------------------------CRUD-------------------------------

Future<List<Map>> getData(String sql) async{
  // on doit récupérer la base de donnée 
 Database? mydb = await db;
 List<Map> l = await mydb!.rawQuery(sql);

 return l;

}

Future<int> InsertData(String sql) async{
// on doit récupérer la base de donnée 
Database? mydb= await db;
int rep= await mydb!.rawInsert(sql);
return rep;
}
Future<int> updateData(String sql) async{
  
  Database? mydb = await db;
  int rep = await mydb!.rawUpdate(sql);

  return rep;

}

Future<int> deletData(String sql) async{
  Database? mydb = await db;
  int rep = await mydb!.rawDelete(sql);

  return rep;

}









}