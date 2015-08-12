class SideEffects

  def self.get_current_effects
    Prescription.having(:side_effects != nil).group(:side_effects)
  end

end 