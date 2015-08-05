class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a? Patient
      @patient = Patient.find(resource.id)
      patient_prescriptions_path(@patient)
    elsif resource.is_a? Doctor
      @doctor = Doctor.find(resource.id)
      doctors_dashboard_path
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password) }

  end
end
