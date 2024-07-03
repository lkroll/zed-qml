(ui_object_definition
    type_name: (_) @name
    (#match? @name "^[A-Z].*")) @item

(function_declaration
    "function" @context
    name: (_) @name) @item
