require 'rails_helper'

feature 'Patient logs in from the homepage and' do

  let(:doctor) {create(:doctor)}
  let(:patient) {create(:patient)}


  scenario 'they log in successfully' do
    visit patient_login_path

    fill_in 'Email', with: patient.email
    fill_in 'Password', with: patient.password

    click_button 'Sign In'

    expect(page.current_path).to eq "/patients/#{patient.id}"
    expect(page).to have_content("Hello #{patient.first_name}")
  end

  scenario 'they enter the wrong password' do
    visit patient_login_path

    fill_in 'Email', with: patient.email
    fill_in 'Password', with: 'password1234blahafasf'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not a valid user' do
    visit patient_login_path

    fill_in 'Email', with: 'doctorwario@nintendo.com'
    fill_in 'Password', with: 'password1234blah'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not able to log in if they are a doctor' do
    visit patient_login_path

    fill_in 'Email', with: doctor.email
    fill_in 'Password', with: doctor.password

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

end