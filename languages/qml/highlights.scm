;;; Snippets based on:
;;; https://github.com/yuja/tree-sitter-qmljs/blob/master/queries/highlights.scm
;;; https://github.com/zed-industries/zed/blob/main/crates/languages/src/javascript/highlights.scm

;;; Variables

(identifier) @variable

;;; Annotations

(ui_annotation
  "@" @operator
  type_name: [
    (identifier) @attribute
    (nested_identifier (identifier) @attribute)
  ])

;;; Properties

(ui_object_definition_binding
  name: [
    (identifier) @property
    (nested_identifier (identifier) @property)
  ])

(ui_binding
  name: [
    (identifier) @property
    (nested_identifier (identifier) @property)
  ])

(ui_binding
  name: (identifier) @property
  value: (expression_statement (_) @variable.parameter))

(ui_property
  name: (identifier) @property)

(ui_required
  name: (identifier) @property)

(ui_list_property_type
  ["<" ">"] @punctuation.bracket)

(ui_object_definition
    type_name: (_) @property
    (#match? @property "^[a-z].*"))

;;; Property identifiers

(property_identifier) @property

;;; Functions

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.call)
)

(function_declaration
    name: (identifier) @function.method)

(call_expression
    function: (identifier) @function.method.call)

;;; Signals

(ui_signal
  name: (identifier) @function.signal)

(ui_signal_parameter
  (identifier) @variable.parameter)

;;; QML Keywords

[
  "as"
  "component"
  "default"
  "import"
  "on"
  "pragma"
  "property"
  "readonly"
  "required"
  "signal"
] @keyword

;;; JavaScript Keywords

[
  "async"
  "await"
  "break"
  "case"
  "catch"
  "class"
  "const"
  "continue"
  "debugger"
  "delete"
  "do"
  "else"
  "export"
  "extends"
  "finally"
  "for"
  "from"
  "function"
  "get"
  "if"
  "in"
  "instanceof"
  "let"
  "new"
  "of"
  "return"
  "set"
  "static"
  "switch"
  "target"
  "throw"
  "try"
  "typeof"
  "var"
  "void"
  "while"
  "with"
  "yield"
] @keyword

;;; Comments

(comment) @comment

;;; Types

(type_identifier) @type

;;; Literals

(this) @variable.special
(super) @variable.special

(number) @number
(string) @string

[
  (true)
  (false)
] @boolean

[
  (null)
  (undefined)
] @constant.builtin

(escape_sequence) @string.escape

;;; Punctuation

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

[
  ";"
  "?."
  "."
  ","
  ":"
] @punctuation.delimiter

;;; Operators

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
] @operator

(ternary_expression ["?" ":"] @operator)
