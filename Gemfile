# frozen_string_literal: true

source 'https://rubygems.org'

branch = ENV.fetch('SOLIDUS_BRANCH', 'v4.6')

# The storefront's promotion features build on the legacy promotion
# system, which lives in the solidus_legacy_promotions gem since Solidus
# 4.4, and its admin assets require solidus_backend, so we test against
# the full solidus gem.
gem 'solidus', git: "https://github.com/solidusio/solidus.git", branch: branch

rails_version = ENV.fetch('RAILS_VERSION', '7.2')
gem 'rails', "~> #{rails_version}"

# Temporarily locking sprockets to v3.x
# see https://github.com/solidusio/solidus/issues/3374
# and https://github.com/rails/sprockets-rails/issues/369
gem 'sprockets', '~> 3'

case ENV['DB']
when 'mysql'
  gem 'mysql2'
when 'postgresql'
  gem 'pg'
else
  if rails_version <= "7.2"
    gem 'sqlite3', "~> 1.7"
  else
    gem 'sqlite3', "~> 2.0"
  end
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g. pry-byebug.
#
# We use `send` instead of calling `eval_gemfile` to work around an issue with
# how Dependabot parses projects: https://github.com/dependabot/dependabot-core/issues/1658.
send(:eval_gemfile, 'Gemfile-local') if File.exist? 'Gemfile-local'
