// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_group_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorGroupDatabse {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorGroupDatabseBuilder databaseBuilder(String name) =>
      _$FloorGroupDatabseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorGroupDatabseBuilder inMemoryDatabaseBuilder() =>
      _$FloorGroupDatabseBuilder(null);
}

class _$FloorGroupDatabseBuilder {
  _$FloorGroupDatabseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorGroupDatabseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorGroupDatabseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorGroupDatabse> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorGroupDatabse();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorGroupDatabse extends FloorGroupDatabse {
  _$FloorGroupDatabse([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorGroupDao? _groupDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `groups` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `startDate` TEXT NOT NULL, `membersCount` INTEGER NOT NULL, `sumSpending` REAL NOT NULL, `archive` INTEGER NOT NULL, `members` TEXT NOT NULL, `receipts` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorGroupDao get groupDao {
    return _groupDaoInstance ??= _$FloorGroupDao(database, changeListener);
  }
}

class _$FloorGroupDao extends FloorGroupDao {
  _$FloorGroupDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _floorGroupInsertionAdapter = InsertionAdapter(
            database,
            'groups',
            (FloorGroup item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'startDate': item.startDate,
                  'membersCount': item.membersCount,
                  'sumSpending': item.sumSpending,
                  'archive': item.archive ? 1 : 0,
                  'members': item.members,
                  'receipts': item.receipts
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FloorGroup> _floorGroupInsertionAdapter;

  @override
  Future<List<FloorGroup>> getAllActiveGroup() async {
    return _queryAdapter.queryList('SELECT * FROM groups WHERE archive = 0',
        mapper: (Map<String, Object?> row) => FloorGroup(
            id: row['id'] as int?,
            title: row['title'] as String,
            startDate: row['startDate'] as String,
            membersCount: row['membersCount'] as int,
            sumSpending: row['sumSpending'] as double,
            archive: (row['archive'] as int) != 0,
            members: row['members'] as String,
            receipts: row['receipts'] as String));
  }

  @override
  Future<List<FloorGroup>> getAllArchiveGroup() async {
    return _queryAdapter.queryList('SELECT * FROM groups WHERE archive = 1',
        mapper: (Map<String, Object?> row) => FloorGroup(
            id: row['id'] as int?,
            title: row['title'] as String,
            startDate: row['startDate'] as String,
            membersCount: row['membersCount'] as int,
            sumSpending: row['sumSpending'] as double,
            archive: (row['archive'] as int) != 0,
            members: row['members'] as String,
            receipts: row['receipts'] as String));
  }

  @override
  Future<FloorGroup?> getGroup(int id) async {
    return _queryAdapter.query('SELECT * FROM groups WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FloorGroup(
            id: row['id'] as int?,
            title: row['title'] as String,
            startDate: row['startDate'] as String,
            membersCount: row['membersCount'] as int,
            sumSpending: row['sumSpending'] as double,
            archive: (row['archive'] as int) != 0,
            members: row['members'] as String,
            receipts: row['receipts'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteGroup(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM groups WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> upsertTodo(FloorGroup group) async {
    await _floorGroupInsertionAdapter.insert(group, OnConflictStrategy.replace);
  }
}
