class SideEffect

  def self.get_side_effects_last_7_days
    ScheduledDose.all.select { |m| !!m.taken_time && !!m.side_effect && m.taken_time > (Time.now - 7.days)}
  end


end 