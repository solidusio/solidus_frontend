# frozen_string_literal: true

require 'bundler'
require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'spree/testing_support/dummy_app/rake_tasks'

RSpec::Core::RakeTask.new
task default: :spec

DummyApp::RakeTasks.new(
  gem_root: File.expand_path(__dir__),
  lib_name: 'solidus_frontend'
)

task test: :spec
task test_app: 'db:reset'

def print_title(gem_name = '')
  title = ["Solidus", gem_name].join(' ').strip
  puts "\n#{'-' * title.size}\n#{title}\n#{'-' * title.size}"
end

desc "clean the whole repository by removing all the generated files"
task :clean do
  rm_f  "Gemfile.lock"
  rm_rf "sandbox"
  rm_rf "pkg"
end

namespace :gem do
  def version
    '3.2.0.alpha'
  end

  desc "Build all solidus gems"
  task :build do
    pkgdir = File.expand_path('pkg', __dir__)
    FileUtils.mkdir_p pkgdir

    gem_name = 'frontend'

    sh "gem build solidus_#{gem_name}.gemspec"
    mv "solidus_#{gem_name}-#{version}.gem", pkgdir
  end

  desc "Install all solidus gems"
  task install: :build do
    gem_name = 'frontend'
    print_title(gem_name)
    gem_path = "pkg/solidus_#{gem_name}-#{version}.gem"

    Bundler.with_clean_env do
      sh "gem install #{gem_path}"
    end
  end

  desc "Release all gems to rubygems"
  task release: :build do
    sh "git tag -a -m \"Version #{version}\" v#{version}"

    gem_name = 'frontend'
    print_title(gem_name)
    gem_path = "pkg/solidus_#{gem_name}-#{version}.gem"
    sh "gem push '#{gem_path}'"
  end
end
