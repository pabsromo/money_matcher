// ignore_for_file: non_constant_identifier_names

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

class Tickets extends Table {
  /// id
  /// event_id - fk to event in Events table
  /// paid_by_person_id - fk to Person table to know who paid ticket
  /// tipInDollars - tip amt in dollars
  /// tipInPercent - tip percentage to use
  /// tipType - to know if dollar or percent
  /// taxes - dollar amt of taxes
  /// taxType - not really necessary anymore, might be used later
  /// subtotal - total of just items
  /// total - total of everything: items, tax, and tip
  /// isScanned - toggle to know if ticket images have been scanned yet
  IntColumn get id => integer().autoIncrement()();
  IntColumn get event_id => integer().references(Events, #id)();
  IntColumn get primary_payer_id =>
      integer().withDefault(const Constant(0)).references(Persons, #id)();
  RealColumn get tipInDollars => real().withDefault(const Constant(0.00))();
  RealColumn get tipInPercent => real().withDefault(const Constant(0.00))();
  TextColumn get tipType => text().withDefault(const Constant('percent'))();
  RealColumn get taxes => real().withDefault(const Constant(0.00))();
  TextColumn get taxType => text().withDefault(const Constant('percent'))();
  RealColumn get subtotal => real().withDefault(const Constant(0.00))();
  RealColumn get total => real().withDefault(const Constant(0.00))();
  BoolColumn get isScanned => boolean().withDefault(const Constant(false))();
}

class Items extends Table {
  /// id
  /// ticket_id
  /// name
  /// amount
  /// currency
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ticket_id => integer().references(Tickets, #id)();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
}

class PersonItems extends Table {
  /// id
  /// person_id
  /// item_id
  /// splitRatio - tells how much to split the item amount for what that person owes
  IntColumn get id => integer().autoIncrement()();
  IntColumn get person_id => integer().references(Persons, #id)();
  IntColumn get item_id => integer().references(Items, #id)();
  RealColumn get splitRatio => real()();
}
