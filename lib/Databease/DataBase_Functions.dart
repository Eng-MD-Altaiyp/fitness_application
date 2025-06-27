import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
DataBase_Metter data_metter = DataBase_Metter();

class DataBase_Metter {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'FITNESS_DB.db');
    Database mydb = await openDatabase(path,
        version: 1, onUpgrade: _onUpgrade, onCreate: _onCreate);
    return mydb;
  }

//_onUpgrade: version يتم استدعئها مره واحده عند تغير ال
  _onUpgrade(Database db, int oldversion, int newversion) async{
    print("onUpgrade ====================================");
  }

//_onCreate : هي داله بيتم استدعائها لمرة واحده فقط عند انشاء قاعده البيانات
  _onCreate(Database db, int version) async {
    try {
      await db.execute('''
  CREATE TABLE "users"(
  "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
   "username" TEXT NOT NULL,
   "useremail" TEXT NOT NULL,
   "userpassword" TEXT NOT NULL,
   "userage" TEXT NOT NULL,
   "usertype" TEXT NOT NULL,
   "userheight" BOOLEAN NOT NULL,
   "userweight" BOOLEAN NOT NULL
      )
  ''');

      // AUTOINCREMENT يفضل تكون في اخر القيد لاتجنب الاخطاء
      //اسم الحقل يكون مختالف عن اسم الجدول
      // اسم الحقل يفضل ان يكون بين دبل كوتيشن " "
      print(
          "Created Database ========================= TTTTTTTTT ==================================  \n");
    } catch (Rerror) {
      print(
          "No Created Database ============================= FFFFFFFFFF ============================== $Rerror  \n");
    }
    /*
    //
    //
    في حاله انه تم انشاء قاعده البيانات و تريد اضافة جدول الى قاعده البيانات فما بينظاف الي في حالتين :
    1- انه تقوم بحذف قاعده البيانات الاوله ثم اضافه قاعده البيانات الجديده
    2- او استخدام داله ال unupdate  الذي بيتم استدعائها عند تغير ال vresion databbase وذالك يتم تغير رقم ال version في حاله تم التغير في قاعده البيانات

    await db.execute('''
  CREATE TABLE "notes"(
  id INTEGER AUTOINCRMENT NOT NULL PRIMARY KEY , notes TEXT NOT NULL )
  ''');

    */
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(
        sql); //rawInsert : وهي داله بترجع انتجر اما صفر او قيمه الذي تم ادخالها 1او 2 الى اخره
    return response;
  }

// rawInsert and rawUpdate and rawDelete : return 1  or 2 or 3 or ... : في حاله نجحت العمليه  , return 0 : في حاله فشلت العملية
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql); //
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql); //
    return response;
  }
}
