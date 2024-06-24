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
] @keyword

;;; Comments

(comment) @comment

;;; Type identifier

(type_identifier) @type

;;; Literals

(number) @number
(string) @string
(true) @boolean
(false) @boolean

;;; Operators

(unary_expression "!" @operator)
(binary_expression [">" "<" "<=" ">=" "&&" "==" "===" "&" "!="] @operator)
(ternary_expression ["?" ":"] @operator)

;;; Object definitions

(ui_object_definition
    type_name: (_) @function.method
    (#match? @function.method "^[A-Z].*"))

;;; Property identifier

(property_identifier) @function.method

;;; Expressions

(member_expression
    object: (identifier) @variable.parameter)

(assignment_expression
    left: (identifier) @variable.parameter)

(expression_statement
    (identifier) @variable.paremeter)

(binary_expression
    (identifier) @variable.parameter)

(variable_declarator
    name: (identifier) @variable.parameter)

;;; Function declaration

(function_declaration
    name: (identifier) @function.method)
