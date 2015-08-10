require 'feature_helper'

feature 'Doctor logs in from the homepage and' do

  let(:doctor) {create(:doctor)}
  let(:patient) {create(:patient)}


  scenario 'they log in successfully' do
    visit new_doctor_session_path

    fill_in 'Email', with: doctor.email
    fill_in 'Password', with: doctor.password

    click_button 'Sign In'

    expect(page.current_path).to eq "/doctors/#{doctor.id}/patients"
    expect(page).to have_content("Hello Dr. #{doctor.last_name}.")
  end

  scenario 'they enter the wrong password' do
    visit new_doctor_session_path

    fill_in 'Email', with: doctor.email
    fill_in 'Password', with: 'password1234blah'

    click_button 'Sign In'

    expect(page.current_path).to eq new_doctor_session_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not a valid user' do
    visit new_doctor_session_path

    fill_in 'Email', with: 'doctorwario@nintendo.com'
    fill_in 'Password', with: 'password1234blah'

    click_button 'Sign In'

    expect(page.current_path).to eq new_doctor_session_path
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'they are not able to log in if they are a patient' do
    visit new_doctor_session_path

    fill_in 'Email', with: patient.email
    fill_in 'Password', with: patient.password

    click_button 'Sign In'

    expect(page.current_path).to e_pathq new_doctor_session_path
    expect(page).to have_content("Invalid email or password.")
  end

end