Geocoder.configure(

  :timeout => 90, 
  :lookup => :mapquest,
  :api_key => ENV['MAPQUEST_API_KEY'],
)
