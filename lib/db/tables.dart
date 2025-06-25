import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username =>
      text().withLength(max: 32).customConstraint('UNIQUE')();
  TextColumn get email => text()();
  TextColumn get passwordHash => text().withLength(min: 8)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Groups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupName => text().withLength(max: 32)();
  IntColumn get user_id =>
      integer().references(Users, #id)(); // Owner of the group
  BoolColumn get isChosenGroup =>
      boolean().withDefault(const Constant(false))();
}

class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(max: 32)();
  TextColumn get lastName => text().withLength(max: 32)();
  TextColumn get nickName => text().withLength(max: 32)();
  TextColumn get email => text()();
  IntColumn get user_id => integer().references(Users, #id).nullable()();
  BoolColumn get isMain => boolean().withDefault(const Constant(false))();
}

class GroupPersons extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get group_id => integer().references(Groups, #id)();
  IntColumn get person_id => integer().references(Persons, #id)();
}

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventName => text()();
  TextColumn get location => text()();
  DateTimeColumn get date => dateTime().nullable()();
  IntColumn get user_id => integer().references(Users, #id)();
  IntColumn get group_id => integer().references(Groups, #id).nullable()();
  BoolColumn get isEditing => boolean().withDefault(const Constant(false))();
}

class Images extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imagePath => text()();
  IntColumn get event_id => integer().references(Events, #id)();
}
