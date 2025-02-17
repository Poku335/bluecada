class User < ApplicationRecord
  belongs_to :role
  has_secure_password
  validates :user_name, presence: true, uniqueness: true
  validate :confirm_password, if: :new_record?
  
  def as_json(options = {})
    super.merge!({
      role_name: role.name
    })
  end

  def self.login(params)
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: user.id })
      { user_id: user.id, token: token, message: "Login successfully", status: :ok }
    else
      { error: "Username or password incorrect", status: :unauthorized }
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
    # params[:order] = "users.#{params[:order]}" || "#{table_name}.id"

    data = super(params.merge!(data: data))
  end

  def self.read_sql_data(params = {})
    sql_body = params[:sql_body]
    results = []

    conn = ActiveRecord::Base.connection

    results = conn.execute(%{#{sql_body}}).to_a

    results
  end

  def self.set_zero
    Patient.destroy_all if Patient.all.present?
    CancerForm.destroy_all if CancerForm.all.present?
    CancerInformation.destroy_all if CancerInformation.all.present?
    InformationDiagnosis.destroy_all if InformationDiagnosis.all.present?
    TreatmentInformation.destroy_all if TreatmentInformation.all.present?
    TreatmentFollowUp.destroy_all if TreatmentFollowUp.all.present?
    DiagnoseParagraph.destroy_all if DiagnoseParagraph.all.present?
    SearchIcdo.destroy_all if SearchIcdo.all.present?
  end
end