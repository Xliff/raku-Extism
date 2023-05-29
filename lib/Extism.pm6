use v6.c;

use NativeCall;

use Extism::Raw::Context;
use Extism::Raw::Definitions;
use Extism::Raw::Extism;

class Extism {
  method log_file (Str() $filename, Str() $log_level) {
    extism_log_file($filename, $log_level);
  }

  method version {
    extism_version();
  }
}

class Extism::Context {
  has ExtismContext $!context;

  submethod BUILD ( :extism-context( :$!context )  )
  { }

  method Extism::Raw::Definitions::ExtismContext
  { $!context }

  method new {
    my $extism-context = extism_context_new();

    $extism-context ?? self.bless( :$extism-context ) !! Nil;
  }

  method free {
    extism_context_free($!context);
  }

  method reset {
    extism_context_reset($!context);
  }

}

class Extism::Function {
  has ExtismFunction $!function;

  submethod BUILD ( :extism-function( :$!function )  )
  { }

  method Extism::Raw::Definitions::ExtismFunction
  { $!function }

  method new (
    Str()                 $name,
    CArray[ExtismValType] $inputs,
    Int()                 $n_inputs,
    CArray[ExtismValType] $outputs,
    Int()                 $n_outputs,
                          &func,
    Pointer               $user_data      = Pointer,
                          &free_user_data = Callable
  ) {
    my ExtismSize ($i, $o) = ($n_inputs, $n_outputs);

    my $extism-function = extism_function_new(
      $name,
      $inputs,
      $i,
      $outputs,
      $o,
      &func,
      $user_data,
      &free_user_data
    );

    $extism-function ?? self.bless( :$extism-function ) !! Nil;
  }

  method free {
    extism_function_free($!function);
  }

  method set_namespace (Str() $namespace) {
    extism_function_set_namespace($!function, $namespace);
  }
}

class Extism::Plugin {
  has ExtismContext $!context;
  has ExtismPlugin  $!plugin;

  submethod BUILD (
    :extism-context( :$!context ),
    :extism-plugin(  :$!plugin  )
  )
    { }

  method Int { $!plugin }

  method new (
    ExtismContext()        $context,
    CArray[uint8]          $wasm,
    Int()                  $wasm_size,
    CArray[ExtismFunction] $functions,
    Int()                  $n_functions,
    Int()                  $with_wasi
  ) {
    my ExtismSize ($w, $n) = ($wasm_size, $n_functions);
    my uint32      $ww     =  $with_wasi;

    my $extism-plugin = extism_plugin_new(
      $context,
      $wasm,
      $w,
      $functions,
      $n,
      $w
    );

    $extism-plugin ?? self.bless( :$context, :$extism-plugin ) !! Nil;
  }

  method call (
    Str()         $func_name,
    CArray[uint8] $data,
    Int()         $data_len
  ) {
    my ExtismSize $d = $data_len;

    extism_plugin_call($!context, $!plugin, $func_name, $data, $d);
  }

  method cancel {
    self.cancel_with_handle( self.cancel_handle );
  }

  method cancel_with_handle (ExtismCancelHandle $handle) {
    extism_plugin_cancel($handle);
  }

  method cancel_handle {
    extism_plugin_cancel_handle($!context, $!plugin);
  }

  method config (Str() $json, Int() $json_size = $json.chars) {
    my ExtismSize $j = $json_size;

    extism_plugin_config($!context, $!plugin, $json, $j);
  }

  method error {
    extism_error($!context, $!plugin);
  }

  method free {
    extism_plugin_free($!context, $!plugin);
  }

  method function_exists (Str() $func_name) {
    extism_plugin_function_exists($!context, $!plugin, $func_name);
  }

  method output_data {
    extism_plugin_output_data($!context, $!plugin);
  }

  method output_length {
    extism_plugin_output_length($!context, $!plugin);
  }

  method update (
    Int()                  $index,
    CArray[uint8]          $wasm,
    Int()                  $wasm_size,
    CArray[ExtismFunction] $functions,
    Int()                  $n_functions,
    bool                   $with_wasi
  ) {
    my ExtismSize ($w, $n) = ($wasm_size, $n_functions);
    my uint32      $ww     =  $with_wasi;

    extism_plugin_update($!context, $index, $wasm, $w, $functions, $n, $ww);
  }

}


class Extism::Plugin::Current {
  has ExtismCurrentPlugin $!plugin;

  submethod BUILD ( :extism-current-plugin( :$!plugin )  )
  { }

  method Extism::Raw::Definitions::ExtismCurrentPlugin
  { $!plugin }

  method new (ExtismCurrentPlugin $extism-current-plugin) {
    $extism-current-plugin ?? self.bless( :$extism-current-plugin ) !! Nil;
  }

  method memory {
    extism_current_plugin_memory($!plugin);
  }

  method memory_alloc (Int() $n) {
    my ExtismSize $nn = $n;

    extism_current_plugin_memory_alloc($!plugin, $n);
  }

  method memory_free (Pointer $ptr) {
    extism_current_plugin_memory_free($!plugin, $ptr);
  }

  method memory_length (Int() $n) {
    my ExtismSize $nn = $n;

    extism_current_plugin_memory_length($!plugin, $nn);
  }

}
