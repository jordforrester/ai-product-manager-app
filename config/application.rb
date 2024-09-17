require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load dotenv only in development or test environment
if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Rails.load
end

module AiProductManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `config.assets.precompile` list any asset file
    # present in vendor/assets directory of gems, if any.
    # Also, add node_modules to the asset load path.
    config.assets.paths << Rails.root.join("node_modules")

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Use Sidekiq as the Active Job backend
    config.active_job.queue_adapter = :async

    # Configure i18n to fallback to default locale
    config.i18n.fallbacks = true

    # Enable CSRF protection by default
    config.action_controller.default_protect_from_forgery = true

    # Configure the application to use UUIDs for primary keys
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    # Enable strict loading of all models by default
    config.active_record.strict_loading_by_default = true

    # Disable automatic generation of helper files
    config.generators.helper = false

    # Configure Action Mailer to use Sidekiq for sending emails
    config.action_mailer.deliver_later_queue_name = nil # Use default queue

    # Configure Active Storage to use Sidekiq for processing variants
    config.active_storage.queues.analysis = nil
    config.active_storage.queues.purge = nil

    # Configure Action Mailbox to use Sidekiq
    config.action_mailbox.queues.incineration = nil
    config.action_mailbox.queues.routing = nil

    # Configure Active Record to use Sidekiq for database tasks
    config.active_record.destroy_association_async_batch_size = 1000
    
    # Add any other custom configurations for your AI Product Manager app here
  end
end
