let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb"
      \   },
      \   "spec/features/*_spec.rb": { "command": "feature" },
      \   "app/services/*.rb": {
      \     "command": "service",
      \     "test": [
      \       "spec/services/%s_spec.rb",
      \       "test/services/%s_test.rb"
      \     ]
      \   },
      \   "app/queries/*_query.rb": {
      \     "command": "query",
      \     "test": [
      \       "spec/queries/%s_spec.rb",
      \       "test/queries/%s_test.rb"
      \     ]
      \   },
      \   "app/graphql/*.rb": {
      \     "command": "graphql",
      \     "test": [
      \       "spec/graphql/%s_spec.rb",
      \       "test/graphql/%s_test.rb"
      \     ],
      \   },
      \ }

let g:projectionist_heuristics = {
      \  "&mix.exs": {
      \    "lib/*.ex": {
      \      "type": "lib",
      \      "alternate": [
      \        "spec/{}_spec.exs",
      \        "test/{}_test.exs",
      \      ],
      \    },
      \    "spec/*_spec.exs": {
      \      "type": "spec",
      \      "alternate": "lib/{}.ex",
      \      "dispatch": "mix espec {file}`=v:lnum ? ':'.v:lnum : ''`"
      \    },
      \    "spec/spec_helper.exs": { "type": "spec" },
      \    "test/*_test.exs": {
      \      "type": "test",
      \      "alternate": "lib/{}.ex",
      \      "dispatch": "mix test {file}`=v:lnum ? ':'.v:lnum : ''`"
      \    },
      \    "test/test_helper.exs": { "type": "test" },
      \    "mix.exs": {
      \      "type": "lib",
      \      "alternate": "mix.lock",
      \      "dispatch": "mix deps.get"
      \    },
      \    "mix.lock": { "alternate": "mix.exs" },
      \    "*": {
      \      "make": "mix",
      \      "console": "iex -S mix"
      \    }
      \  },
      \  "&Cargo.toml": {
      \    "src/*.rs": {
      \      "type": "src",
      \      "dispatch": "cargo test {basename}::tests"
      \    },
      \    "src/main.rs": {
      \      "type": "src",
      \      "dispatch": "cargo test"
      \    },
      \    "Cargo.toml": {
      \      "type": "cargo",
      \      "alternate": "Cargo.lock",
      \      "dispatch": "cargo check"
      \    },
      \    "Cargo.lock": {
      \      "alternate": "Cargo.toml",
      \      "dispatch": "cargo check"
      \    },
      \    "*": { "make": "cargo" }
      \  }
      \ }
