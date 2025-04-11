// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerImage on _ControllerImageBase, Store {
  late final _$imegIndexAtom =
      Atom(name: '_ControllerImageBase.imegIndex', context: context);

  @override
  int get imegIndex {
    _$imegIndexAtom.reportRead();
    return super.imegIndex;
  }

  @override
  set imegIndex(int value) {
    _$imegIndexAtom.reportWrite(value, super.imegIndex, () {
      super.imegIndex = value;
    });
  }

  late final _$_ControllerImageBaseActionController =
      ActionController(name: '_ControllerImageBase', context: context);

  @override
  void nextImage() {
    final _$actionInfo = _$_ControllerImageBaseActionController.startAction(
        name: '_ControllerImageBase.nextImage');
    try {
      return super.nextImage();
    } finally {
      _$_ControllerImageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void prevImage() {
    final _$actionInfo = _$_ControllerImageBaseActionController.startAction(
        name: '_ControllerImageBase.prevImage');
    try {
      return super.prevImage();
    } finally {
      _$_ControllerImageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imegIndex: ${imegIndex}
    ''';
  }
}
