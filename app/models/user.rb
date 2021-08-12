# frozen_string_literal: true

# Admin user model
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class NoAdminsError < StandardError
  end

  private

  def ensure_an_admin_remains
    return unless User.count.zero?

    raise NoAdminsError, "Can't delete last user"
  end
end
