### /usr/local/include/extism.h

use v6.c;

use NativeCall;

use Extism::Raw::Definitions;

unit package Extism::Raw::Extism;

sub extism_current_plugin_memory (ExtismCurrentPlugin $plugin)
  returns CArray[uint8]
  is      native(extism)
  is      export
{ * }

sub extism_current_plugin_memory_alloc (
  ExtismCurrentPlugin $plugin,
  ExtismSize          $n
)
  returns uint64
  is      native(extism)
  is      export
{ * }

sub extism_current_plugin_memory_free (
  ExtismCurrentPlugin $plugin,
  uint64            $ptr
)
  is      native(extism)
  is      export
{ * }

sub extism_current_plugin_memory_length (
  ExtismCurrentPlugin $plugin,
  ExtismSize          $n
)
  returns ExtismSize
  is      native(extism)
  is      export
{ * }

sub extism_function_free (ExtismFunction $ptr)
  is      native(extism)
  is      export
{ * }

sub extism_function_new (
  Str                   $name,
  CArray[ExtismValType] $inputs,
  ExtismSize            $n_inputs,
  CArray[ExtismValType] $outputs,
  ExtismSize            $n_outputs,
                        &func (
                          ExtismCurrentPlugin $plugin,
                          CArray[ExtismVal]   $i,
                          ExtismSize          $n_i,
                          CArray[ExtismVal]   $o,
                          ExtismSize          $n_o,
                          Pointer             $data
                        ),
  Pointer               $user_data,
                        &free_user_data (Pointer)
)
  returns ExtismFunction
  is      native(extism)
  is      export
{ * }

sub extism_function_set_namespace (
  ExtismFunction $ptr,
  Str            $namespace_
)
  is      native(extism)
  is      export
{ * }

sub extism_log_file (
  Str $filename,
  Str $log_level
)
  returns uint32
  is      native(extism)
  is      export
{ * }

sub extism_plugin_cancel (ExtismCancelHandle $handle)
  returns uint32
  is      native(extism)
  is      export
{ * }

sub extism_version
  returns Str
  is      native(extism)
  is      export
{ * }
