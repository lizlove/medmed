class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @doctor = current_doctor
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.find(params[:patient][:id])
    @doctor = current_doctor
    @doctor.patients << @patient
    redirect_to doctor_patients_path
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    current_doctor.patients.destroy(@patient)
    redirect_to doctor_patients_path
  end

  private

  def set_patient
      @patient = Patient.find(params[:id])
    end
# do we need to have password_confirmation here?
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number, :time_zone)
  end
end

