### /usr/local/include/extism.h

use v6.c;

use NativeCall;

use Extism::Raw::Definitions;

unit package Extism::Raw::Extism;

sub extism_context_free (ExtismContext $ctx)
  is      native(extism)
  is      export
{ * }

sub extism_context_new
  returns ExtismContext
  is      native(extism)
  is      export
{ * }

sub extism_error (
  ExtismContext $ctx,
  ExtismPlugin  $plugin
)
  returns Str
  is      native(extism)
  is      export
{ * }

sub extism_context_reset (ExtismContext $ctx)
  is      native(extism)
  is      export
{ * }

sub extism_plugin_call (
  ExtismContext $ctx,
  ExtismPlugin  $plugin_id,
  Str           $func_name,
  CArray[uint8] $data,
  ExtismSize    $data_len
)
  returns int32
  is      native(extism)
  is      export
{ * }

sub extism_plugin_cancel_handle (
  ExtismContext $ctx,
  ExtismPlugin  $plugin
)
  returns ExtismCancelHandle
  is      native(extism)
  is      export
{ * }

sub extism_plugin_config (
  ExtismContext $ctx,
  ExtismPlugin  $plugin,
  Str           $json,
  ExtismSize    $json_size
)
  returns bool
  is      native(extism)
  is      export
{ * }

sub extism_plugin_free (
  ExtismContext $ctx,
  ExtismPlugin  $plugin
)
  is      native(extism)
  is      export
{ * }

sub extism_plugin_function_exists (
  ExtismContext $ctx,
  ExtismPlugin  $plugin,
  Str           $func_name
)
  returns bool
  is      native(extism)
  is      export
{ * }

sub extism_plugin_new (
  ExtismContext          $ctx,
  CArray[uint8]          $wasm,
  ExtismSize             $wasm_size,
  CArray[ExtismFunction] $functions,
  ExtismSize             $n_functions,
  uint32                 $with_wasi
)
  returns ExtismPlugin
  is      native(extism)
  is      export
{ * }

sub extism_plugin_output_data (
  ExtismContext $ctx,
  ExtismPlugin  $plugin
)
  returns CArray[uint8]
  is      native(extism)
  is      export
{ * }

sub extism_plugin_output_length (
  ExtismContext $ctx,
  ExtismPlugin  $plugin
)
  returns ExtismSize
  is      native(extism)
  is      export
{ * }

sub extism_plugin_update (
  ExtismContext          $ctx,
  ExtismPlugin           $index,
  CArray[uint8]          $wasm,
  ExtismSize             $wasm_size,
  CArray[ExtismFunction] $functions,
  ExtismSize             $nfunctions,
  uint32                 $with_wasi
)
  returns uint32
  is      native(extism)
  is      export
{ * }
