# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", integrity: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", integrity: true
pin "@hotwired/stimulus", to: "stimulus.min.js", integrity: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", integrity: true
pin_all_from "app/javascript/controllers", under: "controllers", integrity: true
