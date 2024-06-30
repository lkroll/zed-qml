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

;;; Signals

(ui_signal
  name: (identifier) @function.signal)

(ui_signal_parameter
  (identifier) @variable.parameter)

;;; Keywords

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
  "if"
  "let"
  "else"
  "function"
  "return"
  "var"
  "for"
  "while"
] @keyword

;;; Comments

(comment) @comment

;;; Type identifier

(type_identifier) @type

;;; Literals

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

;;; Operators

(unary_expression "!" @operator)
(binary_expression [">" "<" "<=" ">=" "&&" "==" "===" "&" "!=" "||" "!=="] @operator)
(ternary_expression ["?" ":"] @operator)

;;; Property identifier

(property_identifier) @property

;;; Function calls

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.call)
)

;;; Expressions

(member_expression
    object: (identifier) @variable.parameter)

(assignment_expression
    left: (identifier) @variable.parameter)

(expression_statement
    (identifier) @variable.parameter)

(binary_expression
    (identifier) @variable.parameter)

(variable_declarator
    name: (identifier) @variable.parameter)

;;; Functions

(function_declaration
    name: (identifier) @function.method)

(call_expression
    function: (identifier) @function.method.call)
