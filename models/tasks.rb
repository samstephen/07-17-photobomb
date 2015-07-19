require 'bcrypt'
# require_relative "../database_class_methods.rb"
# require_relative "../database_instance_methods.rb"



class User < ActiveRecord::Base

  attr_reader :password_hash

  has_secure_password

  include BCrypt
  # extend DatabaseClassMethods
  # include DatabaseInstanceMethods
  #
  # attr_accessor :id, :email
  # attr_reader :password
  #
  # def initialize(args={})
  #   @id = args["id"]
  #   @email = args["email"]
  #   @password = args["password"]
  # end



  def forgot_password
    @user = User.find_by_email!(params[:email])
    random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    @user.password = random_password
    @user.save!
    Mailer.create_and_deliver_password_change(@user, random_password)
  end


  def password
    binding.pry


    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


  def json_format
    hash = {}
    hash["id"] = self.id
    hash["email"] = self.email
    hash["password"] = self.password
    hash
  end

  def self.get_user_for_login(email)
    user = ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE email = '#{email}';")[0]
    if user
      password = BCrypt::Password.new(user["password"])
      User.new({"id" => user["id"], "password" => password})
    end
  end

  def correct_password?(attempted_password)
    self.password == attempted_password
  end

end