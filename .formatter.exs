# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 120,
  import_deps: [:ex_gram],
  locals_without_parens: [
    # ExGram DSL functions
    answer: 1,
    answer: 2,
    answer: 3,
    edit: 3,
    send_message: 2,
    send_message: 3
  ]
]
