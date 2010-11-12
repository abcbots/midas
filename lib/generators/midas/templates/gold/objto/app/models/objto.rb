class <%= obj_after_to.camelize %> < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :<%= obj_after_to %>name, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :<%= obj_after_to %>name
  validates_uniqueness_of :<%= obj_after_to %>name, :email, :allow_blank => true
  validates_format_of :<%= obj_after_to %>name, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either <%= obj_after_to %>name or email address
  def self.authenticate(login, pass)
    <%= obj_after_to %> = find_by_<%= obj_after_to %>name(login) || find_by_email(login)
    return <%= obj_after_to %> if <%= obj_after_to %> && <%= obj_after_to %>.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
end
