use v6.c;

use NativeCall;

unit package Extism::Raw::Definitions;

constant extism is export = 'extism',v0;

constant ExtismSize   is export := uint64;
constant ExtismPlugin is export := int32;

constant ExtismValType is export := uint32;
our enum ExtismValTypeEnum is export <
  I32
  I64
  F32
  F64
  V128
  FuncRef
  ExternRef
>;

class ExtismValUnion is repr<CUnion> is export {
  has int32 $.i32;
  has int64 $.i64;
  has num32 $.f32;
  has num64 $.f64;
}

class ExtismVal is repr<CStruct> is export {
  has ExtismValType  $.t;
  HAS ExtismValUnion $.v;
}

class ExtismCancelHandle  is repr<CPointer> is export { }
class ExtismContext       is repr<CPointer> is export { }
class ExtismCurrentPlugin is repr<CPointer> is export { }
class ExtismFunction      is repr<CPointer> is export { }
