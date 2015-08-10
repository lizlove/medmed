module MessagesHelper
  def recipients_options
    s = ''
    if doctor_signed_in?
      current_doctor.patients.each do |user|
        s << "<option value='#{user.id}'>#{user.name}</option>"
      end
    elsif patient_signed_in?
      current_patient.doctors.each do |user|
        s << "<option value='#{user.id}'>#{user.name}</option>"
      end
    end
    s.html_safe
  end
end