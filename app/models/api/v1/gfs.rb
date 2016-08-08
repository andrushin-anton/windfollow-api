class Api::V1::Gfs < ActiveRecord::Base

  def self.interpolate_2_5(point)
    base_floor = point.to_f.floor
    xs = [base_floor, base_floor + 0.25, base_floor + 0.50, base_floor + 0.75, base_floor + 1]
    xs.min_by(1) { |x| (x.to_f - point.to_f).abs }
  end
end
