class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :posts
  has_many :comments

  include BCrypt

  def self.authenticate!(name, password_input)
    @user = self.find_by_name(name)
    if @user && @user.password == password_input
      @user
    else
      nil
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
