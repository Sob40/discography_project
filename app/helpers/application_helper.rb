# frozen_string_literal: true

# Helper methods available across all views
module ApplicationHelper
  def active_class(controller_name)
    'active' if controller.controller_name == controller_name
  end
end
