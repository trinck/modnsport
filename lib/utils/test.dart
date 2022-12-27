
import 'package:flutter/foundation.dart';
import 'package:modnsport/repositories/uri/repository.dart';
import 'package:modnsport/repositories/uri/ModelType.dart';

class Test extends ModelType<Test>
{


  String? nom;

  Test.fromJson(super.json) : super.fromJson(){this.nom=super.json!['nom'];}


}

class Repo1 extends Repository<Test>
{
  Repo1.baseUri(super.baseuri, super.fromJson) : super.baseUri();


}

class Test2 extends ModelType<Test2>{
  Test2.fromJson(super.json) : super.fromJson();

}
