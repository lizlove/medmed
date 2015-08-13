class DoctorComplianceDataController < ApplicationController

   def update
    respond_to do |format|
        format.js { render html }
    end
   end 

end


