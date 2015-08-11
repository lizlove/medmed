class ScheduledDoseView
  attr_reader :scheduled_dose

  def initialize(scheduled_dose)
    @scheduled_dose = scheduled_dose
  end

  def panel_class
    if scheduled_dose.missed?
      "danger"
    elsif scheduled_dose.was_taken?
      "success"
    else
      "primary"
    end
  end

  def side_effect_text
    "Side Effects Recorded" if scheduled_dose.side_effect_present?
  end

  def formatted_time
    scheduled_dose.local_scheduled_time.strftime("%I:%M %p")
  end
end
