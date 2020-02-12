class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { in: 6..20 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    cleaned_email = email.strip.downcase
    p cleaned_email
    user = User.find_by(email: cleaned_email).try(:authenticate, password)
    if user
      return user
    else
      return nil
    end
  end
end
