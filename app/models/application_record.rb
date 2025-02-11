# frozen_string_literal: true

# Base model that all ActiveRecord models inherit from.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
