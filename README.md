Grade Pending 
==========

Grade Pending is a web application that allows users to view and compare restaurant inspection results in New York City. Using publicly available restaurant inspection data from New York City's Open Data platform, New Yorkers now have a place to view information about their favorite restaurants in one simple to use application.


###Data
Data provided by the New York City Department of Health and Mental Hygiene can be found [here](https://nycopendata.socrata.com/Health/Restaurant-Inspection-Results/4vkw-7nck?)

###How to use
Visit us at http://grade-pending.herokuapp.com/.



###How To Contribute
* Fork the repo [here](https://github.com/mendoncakr/GradePending2.0)
* `rake db:migrate`
* Verify that latest dataset is within your public folder to begin
* `rake db:seed`
* `rake geocode` (make sure to configure geocoder in your initializers with geocoding API-key of your choice (i.e. Google)
* `rake add_current_grade`
* `rake fix_names`
* Find an [issue](https://github.com/mendoncakr/GradePending2.0/issues) and or add a new feature!
* Send pull request!


###Contributors:
* [Brendan Susens-Jackson](https://github.com/bsusensjackson)
* [Kenneth Mendonça](https://github.com/mendoncakr)
