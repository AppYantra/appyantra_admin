RSpec.configure do |c|
          c.include AppyantraAdmin::Engine.routes.url_helpers,
            :example_group => {
              :file_path => /\bspec\/*\//
} end