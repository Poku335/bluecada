class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  

  def self.login(params)
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: user.id })
      { user_id: user.id ,token: token, message: "Login successfully" }
    else
      { error: "Username or password incorrect" }
    end
  end


end