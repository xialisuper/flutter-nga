// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_deletion_status_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InputDeletionStatusStore on _InputDeletionStatusStore, Store {
  final _$visibleAtom = Atom(name: '_InputDeletionStatusStore.visible');

  @override
  bool get visible {
    _$visibleAtom.context.enforceReadPolicy(_$visibleAtom);
    _$visibleAtom.reportObserved();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.context.conditionallyRunInAction(() {
      super.visible = value;
      _$visibleAtom.reportChanged();
    }, _$visibleAtom, name: '${_$visibleAtom.name}_set');
  }

  final _$_InputDeletionStatusStoreActionController =
      ActionController(name: '_InputDeletionStatusStore');

  @override
  void setVisible(bool val) {
    final _$actionInfo =
        _$_InputDeletionStatusStoreActionController.startAction();
    try {
      return super.setVisible(val);
    } finally {
      _$_InputDeletionStatusStoreActionController.endAction(_$actionInfo);
    }
  }
}