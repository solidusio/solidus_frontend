# frozen_string_literal: true

require 'spree/testing_support/dummy_app/rake_tasks'
require 'solidus_dev_support/rake_tasks'

DummyApp::RakeTasks.new(
  gem_root: File.expand_path(__dir__),
  lib_name: 'solidus_frontend'
)

SolidusDevSupport::RakeTasks.install

task default: 'extension:specs'
