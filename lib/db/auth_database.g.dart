// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash =
      GeneratedColumn<String>('password_hash', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 8,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, email, passwordHash, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String email;
  final String passwordHash;
  final DateTime createdAt;
  const User(
      {required this.id,
      required this.username,
      required this.email,
      required this.passwordHash,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      passwordHash: Value(passwordHash),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? email,
          String? passwordHash,
          DateTime? createdAt}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, email, passwordHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String passwordHash,
    this.createdAt = const Value.absent(),
  })  : username = Value(username),
        email = Value(email),
        passwordHash = Value(passwordHash);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _user_idMeta =
      const VerificationMeta('user_id');
  @override
  late final GeneratedColumn<int> user_id = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _isChosenGroupMeta =
      const VerificationMeta('isChosenGroup');
  @override
  late final GeneratedColumn<bool> isChosenGroup = GeneratedColumn<bool>(
      'is_chosen_group', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_chosen_group" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, groupName, user_id, isChosenGroup];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(Insertable<Group> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id']!, _user_idMeta));
    } else if (isInserting) {
      context.missing(_user_idMeta);
    }
    if (data.containsKey('is_chosen_group')) {
      context.handle(
          _isChosenGroupMeta,
          isChosenGroup.isAcceptableOrUnknown(
              data['is_chosen_group']!, _isChosenGroupMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      user_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      isChosenGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_chosen_group'])!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  final int id;
  final String groupName;
  final int user_id;
  final bool isChosenGroup;
  const Group(
      {required this.id,
      required this.groupName,
      required this.user_id,
      required this.isChosenGroup});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_name'] = Variable<String>(groupName);
    map['user_id'] = Variable<int>(user_id);
    map['is_chosen_group'] = Variable<bool>(isChosenGroup);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
      id: Value(id),
      groupName: Value(groupName),
      user_id: Value(user_id),
      isChosenGroup: Value(isChosenGroup),
    );
  }

  factory Group.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<int>(json['id']),
      groupName: serializer.fromJson<String>(json['groupName']),
      user_id: serializer.fromJson<int>(json['user_id']),
      isChosenGroup: serializer.fromJson<bool>(json['isChosenGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupName': serializer.toJson<String>(groupName),
      'user_id': serializer.toJson<int>(user_id),
      'isChosenGroup': serializer.toJson<bool>(isChosenGroup),
    };
  }

  Group copyWith(
          {int? id, String? groupName, int? user_id, bool? isChosenGroup}) =>
      Group(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        user_id: user_id ?? this.user_id,
        isChosenGroup: isChosenGroup ?? this.isChosenGroup,
      );
  Group copyWithCompanion(GroupsCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      user_id: data.user_id.present ? data.user_id.value : this.user_id,
      isChosenGroup: data.isChosenGroup.present
          ? data.isChosenGroup.value
          : this.isChosenGroup,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('user_id: $user_id, ')
          ..write('isChosenGroup: $isChosenGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, user_id, isChosenGroup);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.user_id == this.user_id &&
          other.isChosenGroup == this.isChosenGroup);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<int> id;
  final Value<String> groupName;
  final Value<int> user_id;
  final Value<bool> isChosenGroup;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.user_id = const Value.absent(),
    this.isChosenGroup = const Value.absent(),
  });
  GroupsCompanion.insert({
    this.id = const Value.absent(),
    required String groupName,
    required int user_id,
    this.isChosenGroup = const Value.absent(),
  })  : groupName = Value(groupName),
        user_id = Value(user_id);
  static Insertable<Group> custom({
    Expression<int>? id,
    Expression<String>? groupName,
    Expression<int>? user_id,
    Expression<bool>? isChosenGroup,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (user_id != null) 'user_id': user_id,
      if (isChosenGroup != null) 'is_chosen_group': isChosenGroup,
    });
  }

  GroupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? groupName,
      Value<int>? user_id,
      Value<bool>? isChosenGroup}) {
    return GroupsCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      user_id: user_id ?? this.user_id,
      isChosenGroup: isChosenGroup ?? this.isChosenGroup,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<int>(user_id.value);
    }
    if (isChosenGroup.present) {
      map['is_chosen_group'] = Variable<bool>(isChosenGroup.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('user_id: $user_id, ')
          ..write('isChosenGroup: $isChosenGroup')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nickNameMeta =
      const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
      'nick_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _user_idMeta =
      const VerificationMeta('user_id');
  @override
  late final GeneratedColumn<int> user_id = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _isMainMeta = const VerificationMeta('isMain');
  @override
  late final GeneratedColumn<bool> isMain = GeneratedColumn<bool>(
      'is_main', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_main" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, nickName, email, user_id, isMain];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    } else if (isInserting) {
      context.missing(_nickNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id']!, _user_idMeta));
    }
    if (data.containsKey('is_main')) {
      context.handle(_isMainMeta,
          isMain.isAcceptableOrUnknown(data['is_main']!, _isMainMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      nickName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nick_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      user_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      isMain: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_main'])!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String firstName;
  final String lastName;
  final String nickName;
  final String email;
  final int? user_id;
  final bool isMain;
  const Person(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.nickName,
      required this.email,
      this.user_id,
      required this.isMain});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['nick_name'] = Variable<String>(nickName);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || user_id != null) {
      map['user_id'] = Variable<int>(user_id);
    }
    map['is_main'] = Variable<bool>(isMain);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      nickName: Value(nickName),
      email: Value(email),
      user_id: user_id == null && nullToAbsent
          ? const Value.absent()
          : Value(user_id),
      isMain: Value(isMain),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      nickName: serializer.fromJson<String>(json['nickName']),
      email: serializer.fromJson<String>(json['email']),
      user_id: serializer.fromJson<int?>(json['user_id']),
      isMain: serializer.fromJson<bool>(json['isMain']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'nickName': serializer.toJson<String>(nickName),
      'email': serializer.toJson<String>(email),
      'user_id': serializer.toJson<int?>(user_id),
      'isMain': serializer.toJson<bool>(isMain),
    };
  }

  Person copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? nickName,
          String? email,
          Value<int?> user_id = const Value.absent(),
          bool? isMain}) =>
      Person(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nickName: nickName ?? this.nickName,
        email: email ?? this.email,
        user_id: user_id.present ? user_id.value : this.user_id,
        isMain: isMain ?? this.isMain,
      );
  Person copyWithCompanion(PersonsCompanion data) {
    return Person(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      nickName: data.nickName.present ? data.nickName.value : this.nickName,
      email: data.email.present ? data.email.value : this.email,
      user_id: data.user_id.present ? data.user_id.value : this.user_id,
      isMain: data.isMain.present ? data.isMain.value : this.isMain,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickName: $nickName, ')
          ..write('email: $email, ')
          ..write('user_id: $user_id, ')
          ..write('isMain: $isMain')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, firstName, lastName, nickName, email, user_id, isMain);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.nickName == this.nickName &&
          other.email == this.email &&
          other.user_id == this.user_id &&
          other.isMain == this.isMain);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> nickName;
  final Value<String> email;
  final Value<int?> user_id;
  final Value<bool> isMain;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.nickName = const Value.absent(),
    this.email = const Value.absent(),
    this.user_id = const Value.absent(),
    this.isMain = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String nickName,
    required String email,
    this.user_id = const Value.absent(),
    this.isMain = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        nickName = Value(nickName),
        email = Value(email);
  static Insertable<Person> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? nickName,
    Expression<String>? email,
    Expression<int>? user_id,
    Expression<bool>? isMain,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (nickName != null) 'nick_name': nickName,
      if (email != null) 'email': email,
      if (user_id != null) 'user_id': user_id,
      if (isMain != null) 'is_main': isMain,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? nickName,
      Value<String>? email,
      Value<int?>? user_id,
      Value<bool>? isMain}) {
    return PersonsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      user_id: user_id ?? this.user_id,
      isMain: isMain ?? this.isMain,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<int>(user_id.value);
    }
    if (isMain.present) {
      map['is_main'] = Variable<bool>(isMain.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickName: $nickName, ')
          ..write('email: $email, ')
          ..write('user_id: $user_id, ')
          ..write('isMain: $isMain')
          ..write(')'))
        .toString();
  }
}

class $GroupPersonsTable extends GroupPersons
    with TableInfo<$GroupPersonsTable, GroupPerson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupPersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _group_idMeta =
      const VerificationMeta('group_id');
  @override
  late final GeneratedColumn<int> group_id = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "groups" (id)'));
  static const VerificationMeta _person_idMeta =
      const VerificationMeta('person_id');
  @override
  late final GeneratedColumn<int> person_id = GeneratedColumn<int>(
      'person_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, group_id, person_id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_persons';
  @override
  VerificationContext validateIntegrity(Insertable<GroupPerson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_group_idMeta,
          group_id.isAcceptableOrUnknown(data['group_id']!, _group_idMeta));
    } else if (isInserting) {
      context.missing(_group_idMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_person_idMeta,
          person_id.isAcceptableOrUnknown(data['person_id']!, _person_idMeta));
    } else if (isInserting) {
      context.missing(_person_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupPerson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupPerson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      group_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      person_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}person_id'])!,
    );
  }

  @override
  $GroupPersonsTable createAlias(String alias) {
    return $GroupPersonsTable(attachedDatabase, alias);
  }
}

class GroupPerson extends DataClass implements Insertable<GroupPerson> {
  final int id;
  final int group_id;
  final int person_id;
  const GroupPerson(
      {required this.id, required this.group_id, required this.person_id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(group_id);
    map['person_id'] = Variable<int>(person_id);
    return map;
  }

  GroupPersonsCompanion toCompanion(bool nullToAbsent) {
    return GroupPersonsCompanion(
      id: Value(id),
      group_id: Value(group_id),
      person_id: Value(person_id),
    );
  }

  factory GroupPerson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupPerson(
      id: serializer.fromJson<int>(json['id']),
      group_id: serializer.fromJson<int>(json['group_id']),
      person_id: serializer.fromJson<int>(json['person_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'group_id': serializer.toJson<int>(group_id),
      'person_id': serializer.toJson<int>(person_id),
    };
  }

  GroupPerson copyWith({int? id, int? group_id, int? person_id}) => GroupPerson(
        id: id ?? this.id,
        group_id: group_id ?? this.group_id,
        person_id: person_id ?? this.person_id,
      );
  GroupPerson copyWithCompanion(GroupPersonsCompanion data) {
    return GroupPerson(
      id: data.id.present ? data.id.value : this.id,
      group_id: data.group_id.present ? data.group_id.value : this.group_id,
      person_id: data.person_id.present ? data.person_id.value : this.person_id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupPerson(')
          ..write('id: $id, ')
          ..write('group_id: $group_id, ')
          ..write('person_id: $person_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, group_id, person_id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupPerson &&
          other.id == this.id &&
          other.group_id == this.group_id &&
          other.person_id == this.person_id);
}

class GroupPersonsCompanion extends UpdateCompanion<GroupPerson> {
  final Value<int> id;
  final Value<int> group_id;
  final Value<int> person_id;
  const GroupPersonsCompanion({
    this.id = const Value.absent(),
    this.group_id = const Value.absent(),
    this.person_id = const Value.absent(),
  });
  GroupPersonsCompanion.insert({
    this.id = const Value.absent(),
    required int group_id,
    required int person_id,
  })  : group_id = Value(group_id),
        person_id = Value(person_id);
  static Insertable<GroupPerson> custom({
    Expression<int>? id,
    Expression<int>? group_id,
    Expression<int>? person_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (group_id != null) 'group_id': group_id,
      if (person_id != null) 'person_id': person_id,
    });
  }

  GroupPersonsCompanion copyWith(
      {Value<int>? id, Value<int>? group_id, Value<int>? person_id}) {
    return GroupPersonsCompanion(
      id: id ?? this.id,
      group_id: group_id ?? this.group_id,
      person_id: person_id ?? this.person_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (group_id.present) {
      map['group_id'] = Variable<int>(group_id.value);
    }
    if (person_id.present) {
      map['person_id'] = Variable<int>(person_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupPersonsCompanion(')
          ..write('id: $id, ')
          ..write('group_id: $group_id, ')
          ..write('person_id: $person_id')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventNameMeta =
      const VerificationMeta('eventName');
  @override
  late final GeneratedColumn<String> eventName = GeneratedColumn<String>(
      'event_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _user_idMeta =
      const VerificationMeta('user_id');
  @override
  late final GeneratedColumn<int> user_id = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _group_idMeta =
      const VerificationMeta('group_id');
  @override
  late final GeneratedColumn<int> group_id = GeneratedColumn<int>(
      'group_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "groups" (id)'));
  static const VerificationMeta _isEditingMeta =
      const VerificationMeta('isEditing');
  @override
  late final GeneratedColumn<bool> isEditing = GeneratedColumn<bool>(
      'is_editing', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_editing" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, eventName, location, date, user_id, group_id, isEditing];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_name')) {
      context.handle(_eventNameMeta,
          eventName.isAcceptableOrUnknown(data['event_name']!, _eventNameMeta));
    } else if (isInserting) {
      context.missing(_eventNameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id']!, _user_idMeta));
    } else if (isInserting) {
      context.missing(_user_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_group_idMeta,
          group_id.isAcceptableOrUnknown(data['group_id']!, _group_idMeta));
    }
    if (data.containsKey('is_editing')) {
      context.handle(_isEditingMeta,
          isEditing.isAcceptableOrUnknown(data['is_editing']!, _isEditingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_name'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
      user_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      group_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id']),
      isEditing: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_editing'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final String eventName;
  final String location;
  final DateTime? date;
  final int user_id;
  final int? group_id;
  final bool isEditing;
  const Event(
      {required this.id,
      required this.eventName,
      required this.location,
      this.date,
      required this.user_id,
      this.group_id,
      required this.isEditing});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_name'] = Variable<String>(eventName);
    map['location'] = Variable<String>(location);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    map['user_id'] = Variable<int>(user_id);
    if (!nullToAbsent || group_id != null) {
      map['group_id'] = Variable<int>(group_id);
    }
    map['is_editing'] = Variable<bool>(isEditing);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      eventName: Value(eventName),
      location: Value(location),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      user_id: Value(user_id),
      group_id: group_id == null && nullToAbsent
          ? const Value.absent()
          : Value(group_id),
      isEditing: Value(isEditing),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      eventName: serializer.fromJson<String>(json['eventName']),
      location: serializer.fromJson<String>(json['location']),
      date: serializer.fromJson<DateTime?>(json['date']),
      user_id: serializer.fromJson<int>(json['user_id']),
      group_id: serializer.fromJson<int?>(json['group_id']),
      isEditing: serializer.fromJson<bool>(json['isEditing']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventName': serializer.toJson<String>(eventName),
      'location': serializer.toJson<String>(location),
      'date': serializer.toJson<DateTime?>(date),
      'user_id': serializer.toJson<int>(user_id),
      'group_id': serializer.toJson<int?>(group_id),
      'isEditing': serializer.toJson<bool>(isEditing),
    };
  }

  Event copyWith(
          {int? id,
          String? eventName,
          String? location,
          Value<DateTime?> date = const Value.absent(),
          int? user_id,
          Value<int?> group_id = const Value.absent(),
          bool? isEditing}) =>
      Event(
        id: id ?? this.id,
        eventName: eventName ?? this.eventName,
        location: location ?? this.location,
        date: date.present ? date.value : this.date,
        user_id: user_id ?? this.user_id,
        group_id: group_id.present ? group_id.value : this.group_id,
        isEditing: isEditing ?? this.isEditing,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      eventName: data.eventName.present ? data.eventName.value : this.eventName,
      location: data.location.present ? data.location.value : this.location,
      date: data.date.present ? data.date.value : this.date,
      user_id: data.user_id.present ? data.user_id.value : this.user_id,
      group_id: data.group_id.present ? data.group_id.value : this.group_id,
      isEditing: data.isEditing.present ? data.isEditing.value : this.isEditing,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location, ')
          ..write('date: $date, ')
          ..write('user_id: $user_id, ')
          ..write('group_id: $group_id, ')
          ..write('isEditing: $isEditing')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventName, location, date, user_id, group_id, isEditing);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.eventName == this.eventName &&
          other.location == this.location &&
          other.date == this.date &&
          other.user_id == this.user_id &&
          other.group_id == this.group_id &&
          other.isEditing == this.isEditing);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<String> eventName;
  final Value<String> location;
  final Value<DateTime?> date;
  final Value<int> user_id;
  final Value<int?> group_id;
  final Value<bool> isEditing;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.eventName = const Value.absent(),
    this.location = const Value.absent(),
    this.date = const Value.absent(),
    this.user_id = const Value.absent(),
    this.group_id = const Value.absent(),
    this.isEditing = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required String eventName,
    required String location,
    this.date = const Value.absent(),
    required int user_id,
    this.group_id = const Value.absent(),
    this.isEditing = const Value.absent(),
  })  : eventName = Value(eventName),
        location = Value(location),
        user_id = Value(user_id);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<String>? eventName,
    Expression<String>? location,
    Expression<DateTime>? date,
    Expression<int>? user_id,
    Expression<int>? group_id,
    Expression<bool>? isEditing,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventName != null) 'event_name': eventName,
      if (location != null) 'location': location,
      if (date != null) 'date': date,
      if (user_id != null) 'user_id': user_id,
      if (group_id != null) 'group_id': group_id,
      if (isEditing != null) 'is_editing': isEditing,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<String>? eventName,
      Value<String>? location,
      Value<DateTime?>? date,
      Value<int>? user_id,
      Value<int?>? group_id,
      Value<bool>? isEditing}) {
    return EventsCompanion(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      location: location ?? this.location,
      date: date ?? this.date,
      user_id: user_id ?? this.user_id,
      group_id: group_id ?? this.group_id,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<int>(user_id.value);
    }
    if (group_id.present) {
      map['group_id'] = Variable<int>(group_id.value);
    }
    if (isEditing.present) {
      map['is_editing'] = Variable<bool>(isEditing.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('eventName: $eventName, ')
          ..write('location: $location, ')
          ..write('date: $date, ')
          ..write('user_id: $user_id, ')
          ..write('group_id: $group_id, ')
          ..write('isEditing: $isEditing')
          ..write(')'))
        .toString();
  }
}

class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _event_idMeta =
      const VerificationMeta('event_id');
  @override
  late final GeneratedColumn<int> event_id = GeneratedColumn<int>(
      'event_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, imagePath, event_id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(Insertable<Image> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(_event_idMeta,
          event_id.isAcceptableOrUnknown(data['event_id']!, _event_idMeta));
    } else if (isInserting) {
      context.missing(_event_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      event_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event_id'])!,
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final int id;
  final String imagePath;
  final int event_id;
  const Image(
      {required this.id, required this.imagePath, required this.event_id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['event_id'] = Variable<int>(event_id);
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      event_id: Value(event_id),
    );
  }

  factory Image.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      event_id: serializer.fromJson<int>(json['event_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'event_id': serializer.toJson<int>(event_id),
    };
  }

  Image copyWith({int? id, String? imagePath, int? event_id}) => Image(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        event_id: event_id ?? this.event_id,
      );
  Image copyWithCompanion(ImagesCompanion data) {
    return Image(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      event_id: data.event_id.present ? data.event_id.value : this.event_id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('event_id: $event_id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, event_id);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.event_id == this.event_id);
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<int> event_id;
  const ImagesCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.event_id = const Value.absent(),
  });
  ImagesCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    required int event_id,
  })  : imagePath = Value(imagePath),
        event_id = Value(event_id);
  static Insertable<Image> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<int>? event_id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (event_id != null) 'event_id': event_id,
    });
  }

  ImagesCompanion copyWith(
      {Value<int>? id, Value<String>? imagePath, Value<int>? event_id}) {
    return ImagesCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      event_id: event_id ?? this.event_id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (event_id.present) {
      map['event_id'] = Variable<int>(event_id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('event_id: $event_id')
          ..write(')'))
        .toString();
  }
}

class $TicketsTable extends Tickets with TableInfo<$TicketsTable, Ticket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _event_idMeta =
      const VerificationMeta('event_id');
  @override
  late final GeneratedColumn<int> event_id = GeneratedColumn<int>(
      'event_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES events (id)'));
  static const VerificationMeta _tipInDollarsMeta =
      const VerificationMeta('tipInDollars');
  @override
  late final GeneratedColumn<double> tipInDollars = GeneratedColumn<double>(
      'tip_in_dollars', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.00));
  static const VerificationMeta _tipInPercentMeta =
      const VerificationMeta('tipInPercent');
  @override
  late final GeneratedColumn<double> tipInPercent = GeneratedColumn<double>(
      'tip_in_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.00));
  static const VerificationMeta _tipTypeMeta =
      const VerificationMeta('tipType');
  @override
  late final GeneratedColumn<String> tipType = GeneratedColumn<String>(
      'tip_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dollar'));
  static const VerificationMeta _taxesMeta = const VerificationMeta('taxes');
  @override
  late final GeneratedColumn<double> taxes = GeneratedColumn<double>(
      'taxes', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.00));
  static const VerificationMeta _taxTypeMeta =
      const VerificationMeta('taxType');
  @override
  late final GeneratedColumn<String> taxType = GeneratedColumn<String>(
      'tax_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dollar'));
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.00));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.00));
  static const VerificationMeta _isScannedMeta =
      const VerificationMeta('isScanned');
  @override
  late final GeneratedColumn<bool> isScanned = GeneratedColumn<bool>(
      'is_scanned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_scanned" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        event_id,
        tipInDollars,
        tipInPercent,
        tipType,
        taxes,
        taxType,
        subtotal,
        total,
        isScanned
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tickets';
  @override
  VerificationContext validateIntegrity(Insertable<Ticket> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_event_idMeta,
          event_id.isAcceptableOrUnknown(data['event_id']!, _event_idMeta));
    } else if (isInserting) {
      context.missing(_event_idMeta);
    }
    if (data.containsKey('tip_in_dollars')) {
      context.handle(
          _tipInDollarsMeta,
          tipInDollars.isAcceptableOrUnknown(
              data['tip_in_dollars']!, _tipInDollarsMeta));
    }
    if (data.containsKey('tip_in_percent')) {
      context.handle(
          _tipInPercentMeta,
          tipInPercent.isAcceptableOrUnknown(
              data['tip_in_percent']!, _tipInPercentMeta));
    }
    if (data.containsKey('tip_type')) {
      context.handle(_tipTypeMeta,
          tipType.isAcceptableOrUnknown(data['tip_type']!, _tipTypeMeta));
    }
    if (data.containsKey('taxes')) {
      context.handle(
          _taxesMeta, taxes.isAcceptableOrUnknown(data['taxes']!, _taxesMeta));
    }
    if (data.containsKey('tax_type')) {
      context.handle(_taxTypeMeta,
          taxType.isAcceptableOrUnknown(data['tax_type']!, _taxTypeMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('is_scanned')) {
      context.handle(_isScannedMeta,
          isScanned.isAcceptableOrUnknown(data['is_scanned']!, _isScannedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ticket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ticket(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      event_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event_id'])!,
      tipInDollars: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tip_in_dollars'])!,
      tipInPercent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tip_in_percent'])!,
      tipType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tip_type'])!,
      taxes: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}taxes'])!,
      taxType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_type'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      isScanned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_scanned'])!,
    );
  }

  @override
  $TicketsTable createAlias(String alias) {
    return $TicketsTable(attachedDatabase, alias);
  }
}

class Ticket extends DataClass implements Insertable<Ticket> {
/**
   * id
   * event_id
   * tip
   * tipType - to know if dollar or percentage
   * taxes
   * taxType - to know if dollar or percentage
   * subtotal - total of just items
   * total - total of everything: items, tax, and tip
   */
  final int id;
  final int event_id;
  final double tipInDollars;
  final double tipInPercent;
  final String tipType;
  final double taxes;
  final String taxType;
  final double subtotal;
  final double total;
  final bool isScanned;
  const Ticket(
      {required this.id,
      required this.event_id,
      required this.tipInDollars,
      required this.tipInPercent,
      required this.tipType,
      required this.taxes,
      required this.taxType,
      required this.subtotal,
      required this.total,
      required this.isScanned});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(event_id);
    map['tip_in_dollars'] = Variable<double>(tipInDollars);
    map['tip_in_percent'] = Variable<double>(tipInPercent);
    map['tip_type'] = Variable<String>(tipType);
    map['taxes'] = Variable<double>(taxes);
    map['tax_type'] = Variable<String>(taxType);
    map['subtotal'] = Variable<double>(subtotal);
    map['total'] = Variable<double>(total);
    map['is_scanned'] = Variable<bool>(isScanned);
    return map;
  }

  TicketsCompanion toCompanion(bool nullToAbsent) {
    return TicketsCompanion(
      id: Value(id),
      event_id: Value(event_id),
      tipInDollars: Value(tipInDollars),
      tipInPercent: Value(tipInPercent),
      tipType: Value(tipType),
      taxes: Value(taxes),
      taxType: Value(taxType),
      subtotal: Value(subtotal),
      total: Value(total),
      isScanned: Value(isScanned),
    );
  }

  factory Ticket.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ticket(
      id: serializer.fromJson<int>(json['id']),
      event_id: serializer.fromJson<int>(json['event_id']),
      tipInDollars: serializer.fromJson<double>(json['tipInDollars']),
      tipInPercent: serializer.fromJson<double>(json['tipInPercent']),
      tipType: serializer.fromJson<String>(json['tipType']),
      taxes: serializer.fromJson<double>(json['taxes']),
      taxType: serializer.fromJson<String>(json['taxType']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      total: serializer.fromJson<double>(json['total']),
      isScanned: serializer.fromJson<bool>(json['isScanned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'event_id': serializer.toJson<int>(event_id),
      'tipInDollars': serializer.toJson<double>(tipInDollars),
      'tipInPercent': serializer.toJson<double>(tipInPercent),
      'tipType': serializer.toJson<String>(tipType),
      'taxes': serializer.toJson<double>(taxes),
      'taxType': serializer.toJson<String>(taxType),
      'subtotal': serializer.toJson<double>(subtotal),
      'total': serializer.toJson<double>(total),
      'isScanned': serializer.toJson<bool>(isScanned),
    };
  }

  Ticket copyWith(
          {int? id,
          int? event_id,
          double? tipInDollars,
          double? tipInPercent,
          String? tipType,
          double? taxes,
          String? taxType,
          double? subtotal,
          double? total,
          bool? isScanned}) =>
      Ticket(
        id: id ?? this.id,
        event_id: event_id ?? this.event_id,
        tipInDollars: tipInDollars ?? this.tipInDollars,
        tipInPercent: tipInPercent ?? this.tipInPercent,
        tipType: tipType ?? this.tipType,
        taxes: taxes ?? this.taxes,
        taxType: taxType ?? this.taxType,
        subtotal: subtotal ?? this.subtotal,
        total: total ?? this.total,
        isScanned: isScanned ?? this.isScanned,
      );
  Ticket copyWithCompanion(TicketsCompanion data) {
    return Ticket(
      id: data.id.present ? data.id.value : this.id,
      event_id: data.event_id.present ? data.event_id.value : this.event_id,
      tipInDollars: data.tipInDollars.present
          ? data.tipInDollars.value
          : this.tipInDollars,
      tipInPercent: data.tipInPercent.present
          ? data.tipInPercent.value
          : this.tipInPercent,
      tipType: data.tipType.present ? data.tipType.value : this.tipType,
      taxes: data.taxes.present ? data.taxes.value : this.taxes,
      taxType: data.taxType.present ? data.taxType.value : this.taxType,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      total: data.total.present ? data.total.value : this.total,
      isScanned: data.isScanned.present ? data.isScanned.value : this.isScanned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ticket(')
          ..write('id: $id, ')
          ..write('event_id: $event_id, ')
          ..write('tipInDollars: $tipInDollars, ')
          ..write('tipInPercent: $tipInPercent, ')
          ..write('tipType: $tipType, ')
          ..write('taxes: $taxes, ')
          ..write('taxType: $taxType, ')
          ..write('subtotal: $subtotal, ')
          ..write('total: $total, ')
          ..write('isScanned: $isScanned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, event_id, tipInDollars, tipInPercent,
      tipType, taxes, taxType, subtotal, total, isScanned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ticket &&
          other.id == this.id &&
          other.event_id == this.event_id &&
          other.tipInDollars == this.tipInDollars &&
          other.tipInPercent == this.tipInPercent &&
          other.tipType == this.tipType &&
          other.taxes == this.taxes &&
          other.taxType == this.taxType &&
          other.subtotal == this.subtotal &&
          other.total == this.total &&
          other.isScanned == this.isScanned);
}

class TicketsCompanion extends UpdateCompanion<Ticket> {
  final Value<int> id;
  final Value<int> event_id;
  final Value<double> tipInDollars;
  final Value<double> tipInPercent;
  final Value<String> tipType;
  final Value<double> taxes;
  final Value<String> taxType;
  final Value<double> subtotal;
  final Value<double> total;
  final Value<bool> isScanned;
  const TicketsCompanion({
    this.id = const Value.absent(),
    this.event_id = const Value.absent(),
    this.tipInDollars = const Value.absent(),
    this.tipInPercent = const Value.absent(),
    this.tipType = const Value.absent(),
    this.taxes = const Value.absent(),
    this.taxType = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.total = const Value.absent(),
    this.isScanned = const Value.absent(),
  });
  TicketsCompanion.insert({
    this.id = const Value.absent(),
    required int event_id,
    this.tipInDollars = const Value.absent(),
    this.tipInPercent = const Value.absent(),
    this.tipType = const Value.absent(),
    this.taxes = const Value.absent(),
    this.taxType = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.total = const Value.absent(),
    this.isScanned = const Value.absent(),
  }) : event_id = Value(event_id);
  static Insertable<Ticket> custom({
    Expression<int>? id,
    Expression<int>? event_id,
    Expression<double>? tipInDollars,
    Expression<double>? tipInPercent,
    Expression<String>? tipType,
    Expression<double>? taxes,
    Expression<String>? taxType,
    Expression<double>? subtotal,
    Expression<double>? total,
    Expression<bool>? isScanned,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (event_id != null) 'event_id': event_id,
      if (tipInDollars != null) 'tip_in_dollars': tipInDollars,
      if (tipInPercent != null) 'tip_in_percent': tipInPercent,
      if (tipType != null) 'tip_type': tipType,
      if (taxes != null) 'taxes': taxes,
      if (taxType != null) 'tax_type': taxType,
      if (subtotal != null) 'subtotal': subtotal,
      if (total != null) 'total': total,
      if (isScanned != null) 'is_scanned': isScanned,
    });
  }

  TicketsCompanion copyWith(
      {Value<int>? id,
      Value<int>? event_id,
      Value<double>? tipInDollars,
      Value<double>? tipInPercent,
      Value<String>? tipType,
      Value<double>? taxes,
      Value<String>? taxType,
      Value<double>? subtotal,
      Value<double>? total,
      Value<bool>? isScanned}) {
    return TicketsCompanion(
      id: id ?? this.id,
      event_id: event_id ?? this.event_id,
      tipInDollars: tipInDollars ?? this.tipInDollars,
      tipInPercent: tipInPercent ?? this.tipInPercent,
      tipType: tipType ?? this.tipType,
      taxes: taxes ?? this.taxes,
      taxType: taxType ?? this.taxType,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isScanned: isScanned ?? this.isScanned,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (event_id.present) {
      map['event_id'] = Variable<int>(event_id.value);
    }
    if (tipInDollars.present) {
      map['tip_in_dollars'] = Variable<double>(tipInDollars.value);
    }
    if (tipInPercent.present) {
      map['tip_in_percent'] = Variable<double>(tipInPercent.value);
    }
    if (tipType.present) {
      map['tip_type'] = Variable<String>(tipType.value);
    }
    if (taxes.present) {
      map['taxes'] = Variable<double>(taxes.value);
    }
    if (taxType.present) {
      map['tax_type'] = Variable<String>(taxType.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (isScanned.present) {
      map['is_scanned'] = Variable<bool>(isScanned.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketsCompanion(')
          ..write('id: $id, ')
          ..write('event_id: $event_id, ')
          ..write('tipInDollars: $tipInDollars, ')
          ..write('tipInPercent: $tipInPercent, ')
          ..write('tipType: $tipType, ')
          ..write('taxes: $taxes, ')
          ..write('taxType: $taxType, ')
          ..write('subtotal: $subtotal, ')
          ..write('total: $total, ')
          ..write('isScanned: $isScanned')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ticket_idMeta =
      const VerificationMeta('ticket_id');
  @override
  late final GeneratedColumn<int> ticket_id = GeneratedColumn<int>(
      'ticket_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tickets (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  @override
  List<GeneratedColumn> get $columns => [id, ticket_id, name, amount, currency];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ticket_id')) {
      context.handle(_ticket_idMeta,
          ticket_id.isAcceptableOrUnknown(data['ticket_id']!, _ticket_idMeta));
    } else if (isInserting) {
      context.missing(_ticket_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ticket_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ticket_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
/**
   * id
   * ticket_id
   * name
   * amount
   * currency
   */
  final int id;
  final int ticket_id;
  final String name;
  final double amount;
  final String currency;
  const Item(
      {required this.id,
      required this.ticket_id,
      required this.name,
      required this.amount,
      required this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ticket_id'] = Variable<int>(ticket_id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      ticket_id: Value(ticket_id),
      name: Value(name),
      amount: Value(amount),
      currency: Value(currency),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      ticket_id: serializer.fromJson<int>(json['ticket_id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticket_id': serializer.toJson<int>(ticket_id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
    };
  }

  Item copyWith(
          {int? id,
          int? ticket_id,
          String? name,
          double? amount,
          String? currency}) =>
      Item(
        id: id ?? this.id,
        ticket_id: ticket_id ?? this.ticket_id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
      );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      ticket_id: data.ticket_id.present ? data.ticket_id.value : this.ticket_id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('ticket_id: $ticket_id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ticket_id, name, amount, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.ticket_id == this.ticket_id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.currency == this.currency);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<int> ticket_id;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> currency;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.ticket_id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required int ticket_id,
    required String name,
    required double amount,
    this.currency = const Value.absent(),
  })  : ticket_id = Value(ticket_id),
        name = Value(name),
        amount = Value(amount);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<int>? ticket_id,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? currency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticket_id != null) 'ticket_id': ticket_id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? ticket_id,
      Value<String>? name,
      Value<double>? amount,
      Value<String>? currency}) {
    return ItemsCompanion(
      id: id ?? this.id,
      ticket_id: ticket_id ?? this.ticket_id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticket_id.present) {
      map['ticket_id'] = Variable<int>(ticket_id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('ticket_id: $ticket_id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }
}

class $PersonItemsTable extends PersonItems
    with TableInfo<$PersonItemsTable, PersonItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _person_idMeta =
      const VerificationMeta('person_id');
  @override
  late final GeneratedColumn<int> person_id = GeneratedColumn<int>(
      'person_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (id)'));
  static const VerificationMeta _item_idMeta =
      const VerificationMeta('item_id');
  @override
  late final GeneratedColumn<int> item_id = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _splitRatioMeta =
      const VerificationMeta('splitRatio');
  @override
  late final GeneratedColumn<double> splitRatio = GeneratedColumn<double>(
      'split_ratio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, person_id, item_id, splitRatio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'person_items';
  @override
  VerificationContext validateIntegrity(Insertable<PersonItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('person_id')) {
      context.handle(_person_idMeta,
          person_id.isAcceptableOrUnknown(data['person_id']!, _person_idMeta));
    } else if (isInserting) {
      context.missing(_person_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_item_idMeta,
          item_id.isAcceptableOrUnknown(data['item_id']!, _item_idMeta));
    } else if (isInserting) {
      context.missing(_item_idMeta);
    }
    if (data.containsKey('split_ratio')) {
      context.handle(
          _splitRatioMeta,
          splitRatio.isAcceptableOrUnknown(
              data['split_ratio']!, _splitRatioMeta));
    } else if (isInserting) {
      context.missing(_splitRatioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      person_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}person_id'])!,
      item_id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
      splitRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}split_ratio'])!,
    );
  }

  @override
  $PersonItemsTable createAlias(String alias) {
    return $PersonItemsTable(attachedDatabase, alias);
  }
}

class PersonItem extends DataClass implements Insertable<PersonItem> {
/**
   * id
   * person_id
   * item_id
   * splitRatio - tells how much to split the item amount for what that person owes
   */
  final int id;
  final int person_id;
  final int item_id;
  final double splitRatio;
  const PersonItem(
      {required this.id,
      required this.person_id,
      required this.item_id,
      required this.splitRatio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['person_id'] = Variable<int>(person_id);
    map['item_id'] = Variable<int>(item_id);
    map['split_ratio'] = Variable<double>(splitRatio);
    return map;
  }

  PersonItemsCompanion toCompanion(bool nullToAbsent) {
    return PersonItemsCompanion(
      id: Value(id),
      person_id: Value(person_id),
      item_id: Value(item_id),
      splitRatio: Value(splitRatio),
    );
  }

  factory PersonItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonItem(
      id: serializer.fromJson<int>(json['id']),
      person_id: serializer.fromJson<int>(json['person_id']),
      item_id: serializer.fromJson<int>(json['item_id']),
      splitRatio: serializer.fromJson<double>(json['splitRatio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'person_id': serializer.toJson<int>(person_id),
      'item_id': serializer.toJson<int>(item_id),
      'splitRatio': serializer.toJson<double>(splitRatio),
    };
  }

  PersonItem copyWith(
          {int? id, int? person_id, int? item_id, double? splitRatio}) =>
      PersonItem(
        id: id ?? this.id,
        person_id: person_id ?? this.person_id,
        item_id: item_id ?? this.item_id,
        splitRatio: splitRatio ?? this.splitRatio,
      );
  PersonItem copyWithCompanion(PersonItemsCompanion data) {
    return PersonItem(
      id: data.id.present ? data.id.value : this.id,
      person_id: data.person_id.present ? data.person_id.value : this.person_id,
      item_id: data.item_id.present ? data.item_id.value : this.item_id,
      splitRatio:
          data.splitRatio.present ? data.splitRatio.value : this.splitRatio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonItem(')
          ..write('id: $id, ')
          ..write('person_id: $person_id, ')
          ..write('item_id: $item_id, ')
          ..write('splitRatio: $splitRatio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, person_id, item_id, splitRatio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonItem &&
          other.id == this.id &&
          other.person_id == this.person_id &&
          other.item_id == this.item_id &&
          other.splitRatio == this.splitRatio);
}

class PersonItemsCompanion extends UpdateCompanion<PersonItem> {
  final Value<int> id;
  final Value<int> person_id;
  final Value<int> item_id;
  final Value<double> splitRatio;
  const PersonItemsCompanion({
    this.id = const Value.absent(),
    this.person_id = const Value.absent(),
    this.item_id = const Value.absent(),
    this.splitRatio = const Value.absent(),
  });
  PersonItemsCompanion.insert({
    this.id = const Value.absent(),
    required int person_id,
    required int item_id,
    required double splitRatio,
  })  : person_id = Value(person_id),
        item_id = Value(item_id),
        splitRatio = Value(splitRatio);
  static Insertable<PersonItem> custom({
    Expression<int>? id,
    Expression<int>? person_id,
    Expression<int>? item_id,
    Expression<double>? splitRatio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (person_id != null) 'person_id': person_id,
      if (item_id != null) 'item_id': item_id,
      if (splitRatio != null) 'split_ratio': splitRatio,
    });
  }

  PersonItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? person_id,
      Value<int>? item_id,
      Value<double>? splitRatio}) {
    return PersonItemsCompanion(
      id: id ?? this.id,
      person_id: person_id ?? this.person_id,
      item_id: item_id ?? this.item_id,
      splitRatio: splitRatio ?? this.splitRatio,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (person_id.present) {
      map['person_id'] = Variable<int>(person_id.value);
    }
    if (item_id.present) {
      map['item_id'] = Variable<int>(item_id.value);
    }
    if (splitRatio.present) {
      map['split_ratio'] = Variable<double>(splitRatio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonItemsCompanion(')
          ..write('id: $id, ')
          ..write('person_id: $person_id, ')
          ..write('item_id: $item_id, ')
          ..write('splitRatio: $splitRatio')
          ..write(')'))
        .toString();
  }
}

abstract class _$AuthDatabase extends GeneratedDatabase {
  _$AuthDatabase(QueryExecutor e) : super(e);
  $AuthDatabaseManager get managers => $AuthDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $GroupPersonsTable groupPersons = $GroupPersonsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $TicketsTable tickets = $TicketsTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $PersonItemsTable personItems = $PersonItemsTable(this);
  late final UsersDao usersDao = UsersDao(this as AuthDatabase);
  late final PersonsDao personsDao = PersonsDao(this as AuthDatabase);
  late final GroupsDao groupsDao = GroupsDao(this as AuthDatabase);
  late final EventsDao eventsDao = EventsDao(this as AuthDatabase);
  late final ImagesDao imagesDao = ImagesDao(this as AuthDatabase);
  late final TicketsDao ticketsDao = TicketsDao(this as AuthDatabase);
  late final ItemsDao itemsDao = ItemsDao(this as AuthDatabase);
  late final PersonItemsDao personItemsDao =
      PersonItemsDao(this as AuthDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        groups,
        persons,
        groupPersons,
        events,
        images,
        tickets,
        items,
        personItems
      ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String email,
  required String passwordHash,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> email,
  Value<String> passwordHash,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AuthDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GroupsTable, List<Group>> _groupsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.groups,
          aliasName: $_aliasNameGenerator(db.users.id, db.groups.user_id));

  $$GroupsTableProcessedTableManager get groupsRefs {
    final manager = $$GroupsTableTableManager($_db, $_db.groups)
        .filter((f) => f.user_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PersonsTable, List<Person>> _personsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.persons,
          aliasName: $_aliasNameGenerator(db.users.id, db.persons.user_id));

  $$PersonsTableProcessedTableManager get personsRefs {
    final manager = $$PersonsTableTableManager($_db, $_db.persons)
        .filter((f) => f.user_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_personsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.events,
          aliasName: $_aliasNameGenerator(db.users.id, db.events.user_id));

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.user_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AuthDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> groupsRefs(
      Expression<bool> Function($$GroupsTableFilterComposer f) f) {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableFilterComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> personsRefs(
      Expression<bool> Function($$PersonsTableFilterComposer f) f) {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableFilterComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> eventsRefs(
      Expression<bool> Function($$EventsTableFilterComposer f) f) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AuthDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AuthDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> groupsRefs<T extends Object>(
      Expression<T> Function($$GroupsTableAnnotationComposer a) f) {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> personsRefs<T extends Object>(
      Expression<T> Function($$PersonsTableAnnotationComposer a) f) {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
      Expression<T> Function($$EventsTableAnnotationComposer a) f) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.user_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool groupsRefs, bool personsRefs, bool eventsRefs})> {
  $$UsersTableTableManager(_$AuthDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String email,
            required String passwordHash,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            email: email,
            passwordHash: passwordHash,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {groupsRefs = false, personsRefs = false, eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupsRefs) db.groups,
                if (personsRefs) db.persons,
                if (eventsRefs) db.events
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Group>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._groupsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).groupsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.user_id == item.id),
                        typedResults: items),
                  if (personsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Person>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._personsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).personsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.user_id == item.id),
                        typedResults: items),
                  if (eventsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Event>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._eventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).eventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.user_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool groupsRefs, bool personsRefs, bool eventsRefs})>;
typedef $$GroupsTableCreateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  required String groupName,
  required int user_id,
  Value<bool> isChosenGroup,
});
typedef $$GroupsTableUpdateCompanionBuilder = GroupsCompanion Function({
  Value<int> id,
  Value<String> groupName,
  Value<int> user_id,
  Value<bool> isChosenGroup,
});

final class $$GroupsTableReferences
    extends BaseReferences<_$AuthDatabase, $GroupsTable, Group> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _user_idTable(_$AuthDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.groups.user_id, db.users.id));

  $$UsersTableProcessedTableManager get user_id {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_user_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GroupPersonsTable, List<GroupPerson>>
      _groupPersonsRefsTable(_$AuthDatabase db) =>
          MultiTypedResultKey.fromTable(db.groupPersons,
              aliasName:
                  $_aliasNameGenerator(db.groups.id, db.groupPersons.group_id));

  $$GroupPersonsTableProcessedTableManager get groupPersonsRefs {
    final manager = $$GroupPersonsTableTableManager($_db, $_db.groupPersons)
        .filter((f) => f.group_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupPersonsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.events,
          aliasName: $_aliasNameGenerator(db.groups.id, db.events.group_id));

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.group_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GroupsTableFilterComposer
    extends Composer<_$AuthDatabase, $GroupsTable> {
  $$GroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isChosenGroup => $composableBuilder(
      column: $table.isChosenGroup, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get user_id {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> groupPersonsRefs(
      Expression<bool> Function($$GroupPersonsTableFilterComposer f) f) {
    final $$GroupPersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupPersons,
        getReferencedColumn: (t) => t.group_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupPersonsTableFilterComposer(
              $db: $db,
              $table: $db.groupPersons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> eventsRefs(
      Expression<bool> Function($$EventsTableFilterComposer f) f) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.group_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupsTableOrderingComposer
    extends Composer<_$AuthDatabase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isChosenGroup => $composableBuilder(
      column: $table.isChosenGroup,
      builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get user_id {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<bool> get isChosenGroup => $composableBuilder(
      column: $table.isChosenGroup, builder: (column) => column);

  $$UsersTableAnnotationComposer get user_id {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> groupPersonsRefs<T extends Object>(
      Expression<T> Function($$GroupPersonsTableAnnotationComposer a) f) {
    final $$GroupPersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupPersons,
        getReferencedColumn: (t) => t.group_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupPersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.groupPersons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
      Expression<T> Function($$EventsTableAnnotationComposer a) f) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.group_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $GroupsTable,
    Group,
    $$GroupsTableFilterComposer,
    $$GroupsTableOrderingComposer,
    $$GroupsTableAnnotationComposer,
    $$GroupsTableCreateCompanionBuilder,
    $$GroupsTableUpdateCompanionBuilder,
    (Group, $$GroupsTableReferences),
    Group,
    PrefetchHooks Function(
        {bool user_id, bool groupPersonsRefs, bool eventsRefs})> {
  $$GroupsTableTableManager(_$AuthDatabase db, $GroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> user_id = const Value.absent(),
            Value<bool> isChosenGroup = const Value.absent(),
          }) =>
              GroupsCompanion(
            id: id,
            groupName: groupName,
            user_id: user_id,
            isChosenGroup: isChosenGroup,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String groupName,
            required int user_id,
            Value<bool> isChosenGroup = const Value.absent(),
          }) =>
              GroupsCompanion.insert(
            id: id,
            groupName: groupName,
            user_id: user_id,
            isChosenGroup: isChosenGroup,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GroupsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {user_id = false, groupPersonsRefs = false, eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupPersonsRefs) db.groupPersons,
                if (eventsRefs) db.events
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (user_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user_id,
                    referencedTable: $$GroupsTableReferences._user_idTable(db),
                    referencedColumn:
                        $$GroupsTableReferences._user_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupPersonsRefs)
                    await $_getPrefetchedData<Group, $GroupsTable, GroupPerson>(
                        currentTable: table,
                        referencedTable:
                            $$GroupsTableReferences._groupPersonsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupsTableReferences(db, table, p0)
                                .groupPersonsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.group_id == item.id),
                        typedResults: items),
                  if (eventsRefs)
                    await $_getPrefetchedData<Group, $GroupsTable, Event>(
                        currentTable: table,
                        referencedTable:
                            $$GroupsTableReferences._eventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupsTableReferences(db, table, p0).eventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.group_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GroupsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $GroupsTable,
    Group,
    $$GroupsTableFilterComposer,
    $$GroupsTableOrderingComposer,
    $$GroupsTableAnnotationComposer,
    $$GroupsTableCreateCompanionBuilder,
    $$GroupsTableUpdateCompanionBuilder,
    (Group, $$GroupsTableReferences),
    Group,
    PrefetchHooks Function(
        {bool user_id, bool groupPersonsRefs, bool eventsRefs})>;
typedef $$PersonsTableCreateCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String nickName,
  required String email,
  Value<int?> user_id,
  Value<bool> isMain,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> nickName,
  Value<String> email,
  Value<int?> user_id,
  Value<bool> isMain,
});

final class $$PersonsTableReferences
    extends BaseReferences<_$AuthDatabase, $PersonsTable, Person> {
  $$PersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _user_idTable(_$AuthDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.persons.user_id, db.users.id));

  $$UsersTableProcessedTableManager? get user_id {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_user_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GroupPersonsTable, List<GroupPerson>>
      _groupPersonsRefsTable(_$AuthDatabase db) =>
          MultiTypedResultKey.fromTable(db.groupPersons,
              aliasName: $_aliasNameGenerator(
                  db.persons.id, db.groupPersons.person_id));

  $$GroupPersonsTableProcessedTableManager get groupPersonsRefs {
    final manager = $$GroupPersonsTableTableManager($_db, $_db.groupPersons)
        .filter((f) => f.person_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupPersonsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PersonItemsTable, List<PersonItem>>
      _personItemsRefsTable(_$AuthDatabase db) => MultiTypedResultKey.fromTable(
          db.personItems,
          aliasName:
              $_aliasNameGenerator(db.persons.id, db.personItems.person_id));

  $$PersonItemsTableProcessedTableManager get personItemsRefs {
    final manager = $$PersonItemsTableTableManager($_db, $_db.personItems)
        .filter((f) => f.person_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_personItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PersonsTableFilterComposer
    extends Composer<_$AuthDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickName => $composableBuilder(
      column: $table.nickName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMain => $composableBuilder(
      column: $table.isMain, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get user_id {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> groupPersonsRefs(
      Expression<bool> Function($$GroupPersonsTableFilterComposer f) f) {
    final $$GroupPersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupPersons,
        getReferencedColumn: (t) => t.person_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupPersonsTableFilterComposer(
              $db: $db,
              $table: $db.groupPersons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> personItemsRefs(
      Expression<bool> Function($$PersonItemsTableFilterComposer f) f) {
    final $$PersonItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.personItems,
        getReferencedColumn: (t) => t.person_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonItemsTableFilterComposer(
              $db: $db,
              $table: $db.personItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AuthDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickName => $composableBuilder(
      column: $table.nickName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMain => $composableBuilder(
      column: $table.isMain, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get user_id {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get nickName =>
      $composableBuilder(column: $table.nickName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<bool> get isMain =>
      $composableBuilder(column: $table.isMain, builder: (column) => column);

  $$UsersTableAnnotationComposer get user_id {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> groupPersonsRefs<T extends Object>(
      Expression<T> Function($$GroupPersonsTableAnnotationComposer a) f) {
    final $$GroupPersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupPersons,
        getReferencedColumn: (t) => t.person_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupPersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.groupPersons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> personItemsRefs<T extends Object>(
      Expression<T> Function($$PersonItemsTableAnnotationComposer a) f) {
    final $$PersonItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.personItems,
        getReferencedColumn: (t) => t.person_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.personItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PersonsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $PersonsTable,
    Person,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (Person, $$PersonsTableReferences),
    Person,
    PrefetchHooks Function(
        {bool user_id, bool groupPersonsRefs, bool personItemsRefs})> {
  $$PersonsTableTableManager(_$AuthDatabase db, $PersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> nickName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<int?> user_id = const Value.absent(),
            Value<bool> isMain = const Value.absent(),
          }) =>
              PersonsCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            nickName: nickName,
            email: email,
            user_id: user_id,
            isMain: isMain,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String nickName,
            required String email,
            Value<int?> user_id = const Value.absent(),
            Value<bool> isMain = const Value.absent(),
          }) =>
              PersonsCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            nickName: nickName,
            email: email,
            user_id: user_id,
            isMain: isMain,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PersonsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {user_id = false,
              groupPersonsRefs = false,
              personItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupPersonsRefs) db.groupPersons,
                if (personItemsRefs) db.personItems
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (user_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user_id,
                    referencedTable: $$PersonsTableReferences._user_idTable(db),
                    referencedColumn:
                        $$PersonsTableReferences._user_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupPersonsRefs)
                    await $_getPrefetchedData<Person, $PersonsTable,
                            GroupPerson>(
                        currentTable: table,
                        referencedTable:
                            $$PersonsTableReferences._groupPersonsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PersonsTableReferences(db, table, p0)
                                .groupPersonsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.person_id == item.id),
                        typedResults: items),
                  if (personItemsRefs)
                    await $_getPrefetchedData<Person, $PersonsTable,
                            PersonItem>(
                        currentTable: table,
                        referencedTable:
                            $$PersonsTableReferences._personItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PersonsTableReferences(db, table, p0)
                                .personItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.person_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PersonsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $PersonsTable,
    Person,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (Person, $$PersonsTableReferences),
    Person,
    PrefetchHooks Function(
        {bool user_id, bool groupPersonsRefs, bool personItemsRefs})>;
typedef $$GroupPersonsTableCreateCompanionBuilder = GroupPersonsCompanion
    Function({
  Value<int> id,
  required int group_id,
  required int person_id,
});
typedef $$GroupPersonsTableUpdateCompanionBuilder = GroupPersonsCompanion
    Function({
  Value<int> id,
  Value<int> group_id,
  Value<int> person_id,
});

final class $$GroupPersonsTableReferences
    extends BaseReferences<_$AuthDatabase, $GroupPersonsTable, GroupPerson> {
  $$GroupPersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTable _group_idTable(_$AuthDatabase db) =>
      db.groups.createAlias(
          $_aliasNameGenerator(db.groupPersons.group_id, db.groups.id));

  $$GroupsTableProcessedTableManager get group_id {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableManager($_db, $_db.groups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_group_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PersonsTable _person_idTable(_$AuthDatabase db) =>
      db.persons.createAlias(
          $_aliasNameGenerator(db.groupPersons.person_id, db.persons.id));

  $$PersonsTableProcessedTableManager get person_id {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$PersonsTableTableManager($_db, $_db.persons)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_person_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GroupPersonsTableFilterComposer
    extends Composer<_$AuthDatabase, $GroupPersonsTable> {
  $$GroupPersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$GroupsTableFilterComposer get group_id {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableFilterComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableFilterComposer get person_id {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableFilterComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupPersonsTableOrderingComposer
    extends Composer<_$AuthDatabase, $GroupPersonsTable> {
  $$GroupPersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$GroupsTableOrderingComposer get group_id {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableOrderingComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableOrderingComposer get person_id {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableOrderingComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupPersonsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $GroupPersonsTable> {
  $$GroupPersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$GroupsTableAnnotationComposer get group_id {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableAnnotationComposer get person_id {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupPersonsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $GroupPersonsTable,
    GroupPerson,
    $$GroupPersonsTableFilterComposer,
    $$GroupPersonsTableOrderingComposer,
    $$GroupPersonsTableAnnotationComposer,
    $$GroupPersonsTableCreateCompanionBuilder,
    $$GroupPersonsTableUpdateCompanionBuilder,
    (GroupPerson, $$GroupPersonsTableReferences),
    GroupPerson,
    PrefetchHooks Function({bool group_id, bool person_id})> {
  $$GroupPersonsTableTableManager(_$AuthDatabase db, $GroupPersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupPersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupPersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupPersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> group_id = const Value.absent(),
            Value<int> person_id = const Value.absent(),
          }) =>
              GroupPersonsCompanion(
            id: id,
            group_id: group_id,
            person_id: person_id,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int group_id,
            required int person_id,
          }) =>
              GroupPersonsCompanion.insert(
            id: id,
            group_id: group_id,
            person_id: person_id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GroupPersonsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({group_id = false, person_id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (group_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.group_id,
                    referencedTable:
                        $$GroupPersonsTableReferences._group_idTable(db),
                    referencedColumn:
                        $$GroupPersonsTableReferences._group_idTable(db).id,
                  ) as T;
                }
                if (person_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.person_id,
                    referencedTable:
                        $$GroupPersonsTableReferences._person_idTable(db),
                    referencedColumn:
                        $$GroupPersonsTableReferences._person_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GroupPersonsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $GroupPersonsTable,
    GroupPerson,
    $$GroupPersonsTableFilterComposer,
    $$GroupPersonsTableOrderingComposer,
    $$GroupPersonsTableAnnotationComposer,
    $$GroupPersonsTableCreateCompanionBuilder,
    $$GroupPersonsTableUpdateCompanionBuilder,
    (GroupPerson, $$GroupPersonsTableReferences),
    GroupPerson,
    PrefetchHooks Function({bool group_id, bool person_id})>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  required String eventName,
  required String location,
  Value<DateTime?> date,
  required int user_id,
  Value<int?> group_id,
  Value<bool> isEditing,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<String> eventName,
  Value<String> location,
  Value<DateTime?> date,
  Value<int> user_id,
  Value<int?> group_id,
  Value<bool> isEditing,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AuthDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _user_idTable(_$AuthDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.events.user_id, db.users.id));

  $$UsersTableProcessedTableManager get user_id {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_user_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GroupsTable _group_idTable(_$AuthDatabase db) => db.groups
      .createAlias($_aliasNameGenerator(db.events.group_id, db.groups.id));

  $$GroupsTableProcessedTableManager? get group_id {
    final $_column = $_itemColumn<int>('group_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableManager($_db, $_db.groups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_group_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ImagesTable, List<Image>> _imagesRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.images,
          aliasName: $_aliasNameGenerator(db.events.id, db.images.event_id));

  $$ImagesTableProcessedTableManager get imagesRefs {
    final manager = $$ImagesTableTableManager($_db, $_db.images)
        .filter((f) => f.event_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_imagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TicketsTable, List<Ticket>> _ticketsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.tickets,
          aliasName: $_aliasNameGenerator(db.events.id, db.tickets.event_id));

  $$TicketsTableProcessedTableManager get ticketsRefs {
    final manager = $$TicketsTableTableManager($_db, $_db.tickets)
        .filter((f) => f.event_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AuthDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventName => $composableBuilder(
      column: $table.eventName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEditing => $composableBuilder(
      column: $table.isEditing, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get user_id {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableFilterComposer get group_id {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableFilterComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> imagesRefs(
      Expression<bool> Function($$ImagesTableFilterComposer f) f) {
    final $$ImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.images,
        getReferencedColumn: (t) => t.event_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ImagesTableFilterComposer(
              $db: $db,
              $table: $db.images,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> ticketsRefs(
      Expression<bool> Function($$TicketsTableFilterComposer f) f) {
    final $$TicketsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tickets,
        getReferencedColumn: (t) => t.event_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TicketsTableFilterComposer(
              $db: $db,
              $table: $db.tickets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AuthDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventName => $composableBuilder(
      column: $table.eventName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEditing => $composableBuilder(
      column: $table.isEditing, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get user_id {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableOrderingComposer get group_id {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableOrderingComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventName =>
      $composableBuilder(column: $table.eventName, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isEditing =>
      $composableBuilder(column: $table.isEditing, builder: (column) => column);

  $$UsersTableAnnotationComposer get user_id {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.user_id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableAnnotationComposer get group_id {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.group_id,
        referencedTable: $db.groups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.groups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> imagesRefs<T extends Object>(
      Expression<T> Function($$ImagesTableAnnotationComposer a) f) {
    final $$ImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.images,
        getReferencedColumn: (t) => t.event_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.images,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> ticketsRefs<T extends Object>(
      Expression<T> Function($$TicketsTableAnnotationComposer a) f) {
    final $$TicketsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tickets,
        getReferencedColumn: (t) => t.event_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TicketsTableAnnotationComposer(
              $db: $db,
              $table: $db.tickets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EventsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function(
        {bool user_id, bool group_id, bool imagesRefs, bool ticketsRefs})> {
  $$EventsTableTableManager(_$AuthDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> eventName = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
            Value<int> user_id = const Value.absent(),
            Value<int?> group_id = const Value.absent(),
            Value<bool> isEditing = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            eventName: eventName,
            location: location,
            date: date,
            user_id: user_id,
            group_id: group_id,
            isEditing: isEditing,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String eventName,
            required String location,
            Value<DateTime?> date = const Value.absent(),
            required int user_id,
            Value<int?> group_id = const Value.absent(),
            Value<bool> isEditing = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            eventName: eventName,
            location: location,
            date: date,
            user_id: user_id,
            group_id: group_id,
            isEditing: isEditing,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EventsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {user_id = false,
              group_id = false,
              imagesRefs = false,
              ticketsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (imagesRefs) db.images,
                if (ticketsRefs) db.tickets
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (user_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.user_id,
                    referencedTable: $$EventsTableReferences._user_idTable(db),
                    referencedColumn:
                        $$EventsTableReferences._user_idTable(db).id,
                  ) as T;
                }
                if (group_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.group_id,
                    referencedTable: $$EventsTableReferences._group_idTable(db),
                    referencedColumn:
                        $$EventsTableReferences._group_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (imagesRefs)
                    await $_getPrefetchedData<Event, $EventsTable, Image>(
                        currentTable: table,
                        referencedTable:
                            $$EventsTableReferences._imagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EventsTableReferences(db, table, p0).imagesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.event_id == item.id),
                        typedResults: items),
                  if (ticketsRefs)
                    await $_getPrefetchedData<Event, $EventsTable, Ticket>(
                        currentTable: table,
                        referencedTable:
                            $$EventsTableReferences._ticketsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EventsTableReferences(db, table, p0).ticketsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.event_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function(
        {bool user_id, bool group_id, bool imagesRefs, bool ticketsRefs})>;
typedef $$ImagesTableCreateCompanionBuilder = ImagesCompanion Function({
  Value<int> id,
  required String imagePath,
  required int event_id,
});
typedef $$ImagesTableUpdateCompanionBuilder = ImagesCompanion Function({
  Value<int> id,
  Value<String> imagePath,
  Value<int> event_id,
});

final class $$ImagesTableReferences
    extends BaseReferences<_$AuthDatabase, $ImagesTable, Image> {
  $$ImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _event_idTable(_$AuthDatabase db) => db.events
      .createAlias($_aliasNameGenerator(db.images.event_id, db.events.id));

  $$EventsTableProcessedTableManager get event_id {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_event_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ImagesTableFilterComposer
    extends Composer<_$AuthDatabase, $ImagesTable> {
  $$ImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  $$EventsTableFilterComposer get event_id {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImagesTableOrderingComposer
    extends Composer<_$AuthDatabase, $ImagesTable> {
  $$ImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  $$EventsTableOrderingComposer get event_id {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableOrderingComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImagesTableAnnotationComposer
    extends Composer<_$AuthDatabase, $ImagesTable> {
  $$ImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  $$EventsTableAnnotationComposer get event_id {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ImagesTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $ImagesTable,
    Image,
    $$ImagesTableFilterComposer,
    $$ImagesTableOrderingComposer,
    $$ImagesTableAnnotationComposer,
    $$ImagesTableCreateCompanionBuilder,
    $$ImagesTableUpdateCompanionBuilder,
    (Image, $$ImagesTableReferences),
    Image,
    PrefetchHooks Function({bool event_id})> {
  $$ImagesTableTableManager(_$AuthDatabase db, $ImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<int> event_id = const Value.absent(),
          }) =>
              ImagesCompanion(
            id: id,
            imagePath: imagePath,
            event_id: event_id,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String imagePath,
            required int event_id,
          }) =>
              ImagesCompanion.insert(
            id: id,
            imagePath: imagePath,
            event_id: event_id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ImagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({event_id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (event_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.event_id,
                    referencedTable: $$ImagesTableReferences._event_idTable(db),
                    referencedColumn:
                        $$ImagesTableReferences._event_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ImagesTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $ImagesTable,
    Image,
    $$ImagesTableFilterComposer,
    $$ImagesTableOrderingComposer,
    $$ImagesTableAnnotationComposer,
    $$ImagesTableCreateCompanionBuilder,
    $$ImagesTableUpdateCompanionBuilder,
    (Image, $$ImagesTableReferences),
    Image,
    PrefetchHooks Function({bool event_id})>;
typedef $$TicketsTableCreateCompanionBuilder = TicketsCompanion Function({
  Value<int> id,
  required int event_id,
  Value<double> tipInDollars,
  Value<double> tipInPercent,
  Value<String> tipType,
  Value<double> taxes,
  Value<String> taxType,
  Value<double> subtotal,
  Value<double> total,
  Value<bool> isScanned,
});
typedef $$TicketsTableUpdateCompanionBuilder = TicketsCompanion Function({
  Value<int> id,
  Value<int> event_id,
  Value<double> tipInDollars,
  Value<double> tipInPercent,
  Value<String> tipType,
  Value<double> taxes,
  Value<String> taxType,
  Value<double> subtotal,
  Value<double> total,
  Value<bool> isScanned,
});

final class $$TicketsTableReferences
    extends BaseReferences<_$AuthDatabase, $TicketsTable, Ticket> {
  $$TicketsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _event_idTable(_$AuthDatabase db) => db.events
      .createAlias($_aliasNameGenerator(db.tickets.event_id, db.events.id));

  $$EventsTableProcessedTableManager get event_id {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_event_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
          _$AuthDatabase db) =>
      MultiTypedResultKey.fromTable(db.items,
          aliasName: $_aliasNameGenerator(db.tickets.id, db.items.ticket_id));

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.ticket_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TicketsTableFilterComposer
    extends Composer<_$AuthDatabase, $TicketsTable> {
  $$TicketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tipInDollars => $composableBuilder(
      column: $table.tipInDollars, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tipInPercent => $composableBuilder(
      column: $table.tipInPercent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipType => $composableBuilder(
      column: $table.tipType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxes => $composableBuilder(
      column: $table.taxes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taxType => $composableBuilder(
      column: $table.taxType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isScanned => $composableBuilder(
      column: $table.isScanned, builder: (column) => ColumnFilters(column));

  $$EventsTableFilterComposer get event_id {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> itemsRefs(
      Expression<bool> Function($$ItemsTableFilterComposer f) f) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.ticket_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TicketsTableOrderingComposer
    extends Composer<_$AuthDatabase, $TicketsTable> {
  $$TicketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tipInDollars => $composableBuilder(
      column: $table.tipInDollars,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tipInPercent => $composableBuilder(
      column: $table.tipInPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipType => $composableBuilder(
      column: $table.tipType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxes => $composableBuilder(
      column: $table.taxes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taxType => $composableBuilder(
      column: $table.taxType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isScanned => $composableBuilder(
      column: $table.isScanned, builder: (column) => ColumnOrderings(column));

  $$EventsTableOrderingComposer get event_id {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableOrderingComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TicketsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $TicketsTable> {
  $$TicketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get tipInDollars => $composableBuilder(
      column: $table.tipInDollars, builder: (column) => column);

  GeneratedColumn<double> get tipInPercent => $composableBuilder(
      column: $table.tipInPercent, builder: (column) => column);

  GeneratedColumn<String> get tipType =>
      $composableBuilder(column: $table.tipType, builder: (column) => column);

  GeneratedColumn<double> get taxes =>
      $composableBuilder(column: $table.taxes, builder: (column) => column);

  GeneratedColumn<String> get taxType =>
      $composableBuilder(column: $table.taxType, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<bool> get isScanned =>
      $composableBuilder(column: $table.isScanned, builder: (column) => column);

  $$EventsTableAnnotationComposer get event_id {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.event_id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> itemsRefs<T extends Object>(
      Expression<T> Function($$ItemsTableAnnotationComposer a) f) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.ticket_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TicketsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $TicketsTable,
    Ticket,
    $$TicketsTableFilterComposer,
    $$TicketsTableOrderingComposer,
    $$TicketsTableAnnotationComposer,
    $$TicketsTableCreateCompanionBuilder,
    $$TicketsTableUpdateCompanionBuilder,
    (Ticket, $$TicketsTableReferences),
    Ticket,
    PrefetchHooks Function({bool event_id, bool itemsRefs})> {
  $$TicketsTableTableManager(_$AuthDatabase db, $TicketsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TicketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TicketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TicketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> event_id = const Value.absent(),
            Value<double> tipInDollars = const Value.absent(),
            Value<double> tipInPercent = const Value.absent(),
            Value<String> tipType = const Value.absent(),
            Value<double> taxes = const Value.absent(),
            Value<String> taxType = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<bool> isScanned = const Value.absent(),
          }) =>
              TicketsCompanion(
            id: id,
            event_id: event_id,
            tipInDollars: tipInDollars,
            tipInPercent: tipInPercent,
            tipType: tipType,
            taxes: taxes,
            taxType: taxType,
            subtotal: subtotal,
            total: total,
            isScanned: isScanned,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int event_id,
            Value<double> tipInDollars = const Value.absent(),
            Value<double> tipInPercent = const Value.absent(),
            Value<String> tipType = const Value.absent(),
            Value<double> taxes = const Value.absent(),
            Value<String> taxType = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<bool> isScanned = const Value.absent(),
          }) =>
              TicketsCompanion.insert(
            id: id,
            event_id: event_id,
            tipInDollars: tipInDollars,
            tipInPercent: tipInPercent,
            tipType: tipType,
            taxes: taxes,
            taxType: taxType,
            subtotal: subtotal,
            total: total,
            isScanned: isScanned,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TicketsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({event_id = false, itemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemsRefs) db.items],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (event_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.event_id,
                    referencedTable:
                        $$TicketsTableReferences._event_idTable(db),
                    referencedColumn:
                        $$TicketsTableReferences._event_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsRefs)
                    await $_getPrefetchedData<Ticket, $TicketsTable, Item>(
                        currentTable: table,
                        referencedTable:
                            $$TicketsTableReferences._itemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TicketsTableReferences(db, table, p0).itemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.ticket_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TicketsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $TicketsTable,
    Ticket,
    $$TicketsTableFilterComposer,
    $$TicketsTableOrderingComposer,
    $$TicketsTableAnnotationComposer,
    $$TicketsTableCreateCompanionBuilder,
    $$TicketsTableUpdateCompanionBuilder,
    (Ticket, $$TicketsTableReferences),
    Ticket,
    PrefetchHooks Function({bool event_id, bool itemsRefs})>;
typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  required int ticket_id,
  required String name,
  required double amount,
  Value<String> currency,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  Value<int> ticket_id,
  Value<String> name,
  Value<double> amount,
  Value<String> currency,
});

final class $$ItemsTableReferences
    extends BaseReferences<_$AuthDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TicketsTable _ticket_idTable(_$AuthDatabase db) => db.tickets
      .createAlias($_aliasNameGenerator(db.items.ticket_id, db.tickets.id));

  $$TicketsTableProcessedTableManager get ticket_id {
    final $_column = $_itemColumn<int>('ticket_id')!;

    final manager = $$TicketsTableTableManager($_db, $_db.tickets)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ticket_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PersonItemsTable, List<PersonItem>>
      _personItemsRefsTable(_$AuthDatabase db) => MultiTypedResultKey.fromTable(
          db.personItems,
          aliasName: $_aliasNameGenerator(db.items.id, db.personItems.item_id));

  $$PersonItemsTableProcessedTableManager get personItemsRefs {
    final manager = $$PersonItemsTableTableManager($_db, $_db.personItems)
        .filter((f) => f.item_id.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_personItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AuthDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  $$TicketsTableFilterComposer get ticket_id {
    final $$TicketsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ticket_id,
        referencedTable: $db.tickets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TicketsTableFilterComposer(
              $db: $db,
              $table: $db.tickets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> personItemsRefs(
      Expression<bool> Function($$PersonItemsTableFilterComposer f) f) {
    final $$PersonItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.personItems,
        getReferencedColumn: (t) => t.item_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonItemsTableFilterComposer(
              $db: $db,
              $table: $db.personItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AuthDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  $$TicketsTableOrderingComposer get ticket_id {
    final $$TicketsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ticket_id,
        referencedTable: $db.tickets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TicketsTableOrderingComposer(
              $db: $db,
              $table: $db.tickets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  $$TicketsTableAnnotationComposer get ticket_id {
    final $$TicketsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ticket_id,
        referencedTable: $db.tickets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TicketsTableAnnotationComposer(
              $db: $db,
              $table: $db.tickets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> personItemsRefs<T extends Object>(
      Expression<T> Function($$PersonItemsTableAnnotationComposer a) f) {
    final $$PersonItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.personItems,
        getReferencedColumn: (t) => t.item_id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.personItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (Item, $$ItemsTableReferences),
    Item,
    PrefetchHooks Function({bool ticket_id, bool personItemsRefs})> {
  $$ItemsTableTableManager(_$AuthDatabase db, $ItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ticket_id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> currency = const Value.absent(),
          }) =>
              ItemsCompanion(
            id: id,
            ticket_id: ticket_id,
            name: name,
            amount: amount,
            currency: currency,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ticket_id,
            required String name,
            required double amount,
            Value<String> currency = const Value.absent(),
          }) =>
              ItemsCompanion.insert(
            id: id,
            ticket_id: ticket_id,
            name: name,
            amount: amount,
            currency: currency,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ItemsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {ticket_id = false, personItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (personItemsRefs) db.personItems],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ticket_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ticket_id,
                    referencedTable: $$ItemsTableReferences._ticket_idTable(db),
                    referencedColumn:
                        $$ItemsTableReferences._ticket_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (personItemsRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, PersonItem>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._personItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0)
                                .personItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.item_id == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ItemsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (Item, $$ItemsTableReferences),
    Item,
    PrefetchHooks Function({bool ticket_id, bool personItemsRefs})>;
typedef $$PersonItemsTableCreateCompanionBuilder = PersonItemsCompanion
    Function({
  Value<int> id,
  required int person_id,
  required int item_id,
  required double splitRatio,
});
typedef $$PersonItemsTableUpdateCompanionBuilder = PersonItemsCompanion
    Function({
  Value<int> id,
  Value<int> person_id,
  Value<int> item_id,
  Value<double> splitRatio,
});

final class $$PersonItemsTableReferences
    extends BaseReferences<_$AuthDatabase, $PersonItemsTable, PersonItem> {
  $$PersonItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonsTable _person_idTable(_$AuthDatabase db) =>
      db.persons.createAlias(
          $_aliasNameGenerator(db.personItems.person_id, db.persons.id));

  $$PersonsTableProcessedTableManager get person_id {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$PersonsTableTableManager($_db, $_db.persons)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_person_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ItemsTable _item_idTable(_$AuthDatabase db) => db.items
      .createAlias($_aliasNameGenerator(db.personItems.item_id, db.items.id));

  $$ItemsTableProcessedTableManager get item_id {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_item_idTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PersonItemsTableFilterComposer
    extends Composer<_$AuthDatabase, $PersonItemsTable> {
  $$PersonItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get splitRatio => $composableBuilder(
      column: $table.splitRatio, builder: (column) => ColumnFilters(column));

  $$PersonsTableFilterComposer get person_id {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableFilterComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableFilterComposer get item_id {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.item_id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonItemsTableOrderingComposer
    extends Composer<_$AuthDatabase, $PersonItemsTable> {
  $$PersonItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get splitRatio => $composableBuilder(
      column: $table.splitRatio, builder: (column) => ColumnOrderings(column));

  $$PersonsTableOrderingComposer get person_id {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableOrderingComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableOrderingComposer get item_id {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.item_id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonItemsTableAnnotationComposer
    extends Composer<_$AuthDatabase, $PersonItemsTable> {
  $$PersonItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get splitRatio => $composableBuilder(
      column: $table.splitRatio, builder: (column) => column);

  $$PersonsTableAnnotationComposer get person_id {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.person_id,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ItemsTableAnnotationComposer get item_id {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.item_id,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PersonItemsTableTableManager extends RootTableManager<
    _$AuthDatabase,
    $PersonItemsTable,
    PersonItem,
    $$PersonItemsTableFilterComposer,
    $$PersonItemsTableOrderingComposer,
    $$PersonItemsTableAnnotationComposer,
    $$PersonItemsTableCreateCompanionBuilder,
    $$PersonItemsTableUpdateCompanionBuilder,
    (PersonItem, $$PersonItemsTableReferences),
    PersonItem,
    PrefetchHooks Function({bool person_id, bool item_id})> {
  $$PersonItemsTableTableManager(_$AuthDatabase db, $PersonItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> person_id = const Value.absent(),
            Value<int> item_id = const Value.absent(),
            Value<double> splitRatio = const Value.absent(),
          }) =>
              PersonItemsCompanion(
            id: id,
            person_id: person_id,
            item_id: item_id,
            splitRatio: splitRatio,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int person_id,
            required int item_id,
            required double splitRatio,
          }) =>
              PersonItemsCompanion.insert(
            id: id,
            person_id: person_id,
            item_id: item_id,
            splitRatio: splitRatio,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PersonItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({person_id = false, item_id = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (person_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.person_id,
                    referencedTable:
                        $$PersonItemsTableReferences._person_idTable(db),
                    referencedColumn:
                        $$PersonItemsTableReferences._person_idTable(db).id,
                  ) as T;
                }
                if (item_id) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.item_id,
                    referencedTable:
                        $$PersonItemsTableReferences._item_idTable(db),
                    referencedColumn:
                        $$PersonItemsTableReferences._item_idTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PersonItemsTableProcessedTableManager = ProcessedTableManager<
    _$AuthDatabase,
    $PersonItemsTable,
    PersonItem,
    $$PersonItemsTableFilterComposer,
    $$PersonItemsTableOrderingComposer,
    $$PersonItemsTableAnnotationComposer,
    $$PersonItemsTableCreateCompanionBuilder,
    $$PersonItemsTableUpdateCompanionBuilder,
    (PersonItem, $$PersonItemsTableReferences),
    PersonItem,
    PrefetchHooks Function({bool person_id, bool item_id})>;

class $AuthDatabaseManager {
  final _$AuthDatabase _db;
  $AuthDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$GroupPersonsTableTableManager get groupPersons =>
      $$GroupPersonsTableTableManager(_db, _db.groupPersons);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db, _db.images);
  $$TicketsTableTableManager get tickets =>
      $$TicketsTableTableManager(_db, _db.tickets);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$PersonItemsTableTableManager get personItems =>
      $$PersonItemsTableTableManager(_db, _db.personItems);
}
