class Inspection < ActiveRecord::Base
  belongs_to :restaurant

  def self.violation_cache
  	Rails.cache.fetch('violation_code') { all.pluck(:violation_code).flatten }
  end
  
end
