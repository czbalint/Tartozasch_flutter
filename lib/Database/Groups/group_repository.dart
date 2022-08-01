import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class GroupRepository<T> {
  Future<void> init();

  Future<List<T>> getAllActiveGroup();

  Future<List<T>> getAllArchiveGroup();

  Future<T> getGroup(int id);

  Future<void> upsertGroup(T group);

  Future<void> deleteGroup(T group);
}