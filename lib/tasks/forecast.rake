namespace :forecast do

    desc 'Find forecast notifications'

    task notifications: :environment do
        # get alerts where last_sent_time was more than 1 day
        Api::V1::Alert.where('forecast_last_time_sent <= ? OR forecast_last_time_sent IS NULL', 1.day.ago.to_formatted_s(:db)).find_each do |alert|
            
        end
    end
end