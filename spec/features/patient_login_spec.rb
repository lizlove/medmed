require 'rails_helper'

feature 'Patient logs in from the homepage and' do

  let(:doctor) {create(:doctor)}
  let(:patient) {create(:patient)}


  scenario 'they log in successfully' do
    visit new_patient_session

    fill_in 'Email', with: patient.email
    fill_in 'Password', with: patient.password

    click_button 'Sign In'

    expect(page.current_path).to eq "/patients/#{patient.id}"
    expect(page).to have_content("Hello #{patient.first_name}")
  end

  scenario 'they enter the wrong password' do
    visit new_patient_session

    fill_in 'Email', with: patient.email
    fill_in 'Password', with: 'password1234blahafasf'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not a valid user' do
    visit new_patient_session

    fill_in 'Email', with: 'doctorwario@nintendo.com'
    fill_in 'Password', with: 'password1234blah'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not able to log in if they are a doctor' do
    visit new_patient_session

    fill_in 'Email', with: doctor.email
    fill_in 'Password', with: doctor.password

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they missed one of yesterdays doses' do
    visit new_patient_session

    fill_in 'Email', with: patient_missed_dose.email
    fill_in 'Password', with: 'password'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to have_content("Warning")
  end

  scenario 'they did not miss one of yesterdays doses' do
    visit new_patient_session

    fill_in 'Email', with: patient_no_missed_doses.email
    fill_in 'Password', with: 'password'

    click_button 'Sign In'

    expect(page.current_path).to eq patient_login_path
    expect(page).to_not have_content("Warning")
  end


end