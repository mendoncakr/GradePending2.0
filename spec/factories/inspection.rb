FactoryGirl.define do 
	factory :inspection do 
		association :restaurant, :factory => :restaurant
		action "D"
		violation_code "02B"
		score "2"
		current_grade "A"
		created_at {Chronic.parse("09/22/2014")}
		updated_at {Chronic.parse("09/22/2014")}
		inspection_date {Chronic.parse("09/15/2014")}
		grade_date {Chronic.parse("09/16/2014")}
		record_date {Chronic.parse("09/16/2014")}
	end
end
