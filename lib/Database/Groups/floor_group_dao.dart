import 'package:floor/floor.dart';
import 'floor_group.dart';

@dao
abstract class FloorGroupDao {
  @Query('SELECT * FROM groups WHERE archive = 0')
  Future<List<FloorGroup>> getAllActiveGroup();

  @Query('SELECT * FROM groups WHERE archive = 1')
  Future<List<FloorGroup>> getAllArchiveGroup();

  @Query('SELECT * FROM groups WHERE id = :id')
  Future<FloorGroup?> getGroup(int id);

  @Query('DELETE FROM groups WHERE id = :id')
  Future<void> deleteGroup(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertTodo(FloorGroup group);
}