import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username =>
      text().withLength(min: 3, max: 32).customConstraint('UNIQUE')();
  TextColumn get email => text().withLength(min: 6, max: 100)();
  TextColumn get passwordHash => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
