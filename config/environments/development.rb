# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable Action Controller caching. By default, caching is disabled.
  # Run `rails dev:cache` to toggle caching in development mode.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.public_file_server.headers = { 'cache-control' => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store # Desactiva caché en desarrollo
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # Si no usas subida de archivos, puedes comentarlo.
  # config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  # Set localhost to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Desactivar logs de etiquetas en consultas SQL (innecesario en desarrollo).
  # config.active_record.query_log_tags_enabled = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Raises error for missing translations (útil para detectar errores en i18n).
  config.i18n.raise_on_missing_translations = true

  # Annotate rendered views with file names (útil para debugging en desarrollo).
  config.action_view.annotate_rendered_view_with_filenames = true

  # Permitir acceso a Action Cable desde cualquier origen (si se usará en el futuro).
  config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Aplicar autocorrección de RuboCop a archivos generados por `bin/rails generate`.
  # config.generators.apply_rubocop_autocorrect_after_generate!
end
