class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  validates :user_name, presence: true, uniqueness: true
  validate :confirm_password

  def self.login(params)
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: user.id })
      { user_id: user.id ,token: token, message: "Login successfully" }
    else
      { error: "Username or password incorrect" }
    end
  end

  def confirm_password
    if password != password_confirmation
      p "password #{password} password_confirm#{password_confirmation}"
      errors.add(:password, "Password and password confirmation must be same")
    end
  end

  def self.search(params = {})  
    data = all
    data = data.select %(
    users.id,
    users.tel,
    users.first_name,
    users.last_name,
    roles.name as role_name
  )
      
    data = data.joins('LEFT JOIN roles ON roles.id = users.role_id')
  
    params[:inner_joins] = %i[]
    
    params[:keywords_columns] = []
    params[:order] = "users.#{params[:order]}" || "users.id"


    data = super(params.merge!(data: data))
  end
end