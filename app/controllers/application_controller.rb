class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected


  def after_sign_in_path_for(resource)
    if resource.class.is_a? Patient
      redirect_to(patient_prescriptions_path)
    elsif resource.class.is_a? Doctor
      redirect_to(doctor_patients_path)
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password) }

  end
end
