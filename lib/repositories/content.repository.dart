import 'package:modnsport/models/content.model.dart';
import 'package:modnsport/repositories/uri/repository.dart';

class ContentRepository extends Repository<Content>
{
  ContentRepository.baseUri(super.baseUri, super.fromJson) : super.baseUri();

}