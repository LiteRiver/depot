class User < ApplicationRecord
  has_secure_password

  attr_accessor :current_password

  validates :name, presence: true, uniqueness: true
  validates :current_password, presence: true, on: :update
  validate :ensure_authenticated, on: :update

  after_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    return if User.any?

    raise Error, "Can't delete last user"
  end

  def ensure_authenticated
    return if errors[:current_password].any?
    return if authenticate(current_password)

    errors.add(:current_password, 'Invalid password')
  end

  class Error < StandardError
  end
end
