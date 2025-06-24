import 'package:money_matcher/shared/domain/entities/person.dart';

class Group {
  final String name;
  Set<Person> groupPersons;

  Group({
    required this.name,
    Set<Person>? groupPersons,
  }) : groupPersons = groupPersons ?? {};
}
