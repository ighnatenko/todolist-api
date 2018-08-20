# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'TodolistApi'
  config.api_base_url            = '/api/v1'
  config.doc_base_url            = '/apipie'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate = false
end
