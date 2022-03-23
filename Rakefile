# frozen_string_literal: true

require 'bundler'

task default: :spec

def print_title(gem_name = '')
  title = ["Solidus", gem_name].join(' ').strip
  puts "\n#{'-' * title.size}\n#{title}\n#{'-' * title.size}"
end

def subproject_task(project, task, title: project, task_name: nil)
  task_name ||= "#{task}:#{project}"
  task task_name do
    print_title(title)
    Dir.chdir("#{File.dirname(__FILE__)}/#{project}") do
      sh "rake #{task}"
    end
  end
end

%w[spec db:drop db:create db:migrate db:reset].each do |task|
  project = 'frontend'
  desc "Run specs for #{project}" if task == 'spec'
  subproject_task(project, task)

  desc "Run rake #{task} for each Solidus engine"
  task task => "#{task}:frontend"
end

task :spec

task test: :spec
task test_app: 'db:reset'

desc "clean the whole repository by removing all the generated files"
task :clean do
  rm_f  "Gemfile.lock"
  rm_rf "sandbox"
  rm_rf "pkg"

  gem_name = 'frontend'
  print_title(gem_name)
  rm_f  "#{gem_name}/Gemfile.lock"
  rm_rf "#{gem_name}/pkg"
  rm_rf "#{gem_name}/spec/dummy"
end

namespace :gem do
  def version
    require_relative 'core/lib/spree/core/version'
    Spree.solidus_version
  end

  desc "Build all solidus gems"
  task :build do
    pkgdir = File.expand_path('pkg', __dir__)
    FileUtils.mkdir_p pkgdir

    gem_name = 'frontend'

    Dir.chdir(gem_name) do
      sh "gem build solidus_#{gem_name}.gemspec"
      mv "solidus_#{gem_name}-#{version}.gem", pkgdir
    end
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
