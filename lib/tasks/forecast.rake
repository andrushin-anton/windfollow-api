namespace :forecast do

    desc 'Find forecast notifications'

    task notifications: :environment do
        forecast_spots = {}
        
        # get alerts where last_sent_time was more than 1 day
        Api::V1::Alert.where('forecast_last_time_sent <= ? OR forecast_last_time_sent IS NULL', 1.day.ago.to_formatted_s(:db)).find_each do |alert|
            found_hour = nil
            # check if data exists in temp hash            
            if forecast_spots.key?(alert.spot_id)
                forecast = forecast_spots[alert.spot_id]
            else
                # get forecast data from db
                forecast = Api::V1::Gfs.find_data_by_coordinates(alert.spot.geo_lat, alert.spot.geo_lon, 'c', 'm/s', 120)    
                forecast_spots[alert.spot_id] = forecast
            end           

            unless forecast.nil?
                # we are interested in the first 5 days begining from the last
                forecast.each do |row|
                    # check the wind speed
                    if row.wind_speed >= alert.speed_from && row.wind_speed <= alert.speed_to
                        # check wind direction
                        if alert.direction.include? row.wind_dir.downcase
                            # found it!
                            found_hour = row
                        end
                    end                    
                end
            end

            unless found_hour.nil?
                notification = Api::V1::Notification.new
                notification.user_id = alert.user_id
                notification.event_type = Api::V1::Notification::TYPE_FORECAST_ALERT
                notification.content = { :vt => found_hour.vt.to_formatted_s(:db), :spot => alert.spot, :direction => found_hour.wind_dir, :wind => found_hour.wind_speed }.to_json
                notification.event_object_id = alert.spot.id
                notification.save								
            end
        end

        # Send push notifactions
        SendForecastPushJob.set(wait: 5.seconds).perform_later()
    end
end