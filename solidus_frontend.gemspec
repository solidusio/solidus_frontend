# frozen_string_literal: true

require_relative 'lib/spree/frontend/version.rb'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'solidus_frontend'
  s.version     = Spree::Frontend.version

  s.summary     = <<~SUMMARY
    Legacy cart and storefront for the Solidus e-commerce project.
    For new Solidus apps, we recommend that you use
    [SolidusStarterFrontend](https://github.com/solidusio/solidus_starter_frontend)
    instead.
  SUMMARY

  s.description = s.summary

  s.author      = 'Solidus Team'
  s.email       = 'contact@solidus.io'
  s.homepage    = 'http://solidus.io'
  s.license     = 'BSD-3-Clause'

  s.metadata['rubygems_mfa_required'] = 'true'
  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = 'https://github.com/solidusio/solidus_frontend'
  s.metadata['changelog_uri'] = 'https://github.com/solidusio/solidus_frontend/blob/master/CHANGELOG.md'

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec|script)/})
  end

  s.required_ruby_version = '>= 2.5.0'
  s.required_rubygems_version = '>= 1.8.23'

  s.add_dependency 'solidus_api', '>= 3.2.0.alpha'
  s.add_dependency 'solidus_core', '>= 3.2.0.alpha'

  s.add_dependency 'canonical-rails', '~> 0.2.10'
  s.add_dependency 'font-awesome-rails', '~> 4.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'kaminari', '~> 1.1'
  s.add_dependency 'responders'
  s.add_dependency 'sassc-rails'
  s.add_dependency 'truncate_html', '~> 0.9', '>= 0.9.2'

  s.add_development_dependency 'capybara-accessible'
  s.add_development_dependency 'solidus_dev_support', '~> 2.5'
  s.add_development_dependency 'rspec-activemodel-mocks', '~> 1.1'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'generator_spec'
end
