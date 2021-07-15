# frozen_string_literal: true

# The main model class do be used as base for models in the application
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
