class SideEffect

  def self.get_side_effects_last_7_days
    ScheduledDose.all.select { |m| m.side_effect != nil && m.taken_time > (Time.now - 7.days)}
  end

  def self.get_

  end 


end 