class TimeZoneView

  def self.get_options_for_select
    @tz = ActiveSupport::TimeZone.all
    @tz.collect do |t|
      [t.name, t.name]
    end
  end
end
