# frozen_string_literal: true

require 'spree/testing_support/dummy_app/rake_tasks'
require 'solidus_dev_support/rake_tasks'
require 'bundler/gem_tasks'

DummyApp::RakeTasks.new(
  gem_root: File.expand_path(__dir__),
  lib_name: 'solidus_frontend'
)

require 'rake/clean'
CLOBBER.include('spec/dummy')

SolidusDevSupport::RakeTasks.install

# The combined `db:drop db:create db:migrate` invocation used to set up the
# dummy database leaves SQLite with a stale connection to the dropped
# database file, so the migrated schema never reaches the file on disk.
# Re-running the migrations in a fresh process writes the real database.
task 'extension:test_app' do
  if ENV['DB'].nil? || %w[sqlite sqlite3].include?(ENV['DB'])
    cd 'spec/dummy' do
      sh 'bin/rails db:migrate VERBOSE=false RAILS_ENV=test'
    end
  end
end

task default: 'extension:specs'
