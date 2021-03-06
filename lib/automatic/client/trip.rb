module Automatic
  module Client
    class Trip
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def uri
        @attributes.fetch('uri', nil)
      end

      def vehicle
        @vehicle ||= Automatic::Client::Vehicle.new(vehicle_params)
      end

      def user
        @user ||= Automatic::Client::User.new(user_params)
      end

      def end_location
        @end_location ||= Automatic::Client::Location.new(end_location_params)
      end

      def end_time
        @attributes.fetch('end_time', nil)
      end

      def end_at
        end_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      def end_time_zone
        @attributes.fetch('end_time_zone', nil)
      end

      def start_location
        @start_location ||= Automatic::Client::Location.new(start_location_params)
      end

      def start_time
        @attributes.fetch('start_time', nil)
      end

      def start_at
        start_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      def start_time_zone
        @attributes.fetch('start_time_zone', nil)
      end

      # Return the elapsed time of the Trip in minutes
      #
      # TODO: Take down to seconds and support (seconds, minutes, hours)
      # TODO: Create a helper extension that will be smart and know seconds and minutes
      #
      # @return [Float] Elapsed time of the trip
      def elapsed_time
        seconds = (self.end_at.to_i - self.start_at.to_i)
        (seconds / 60)
      end

      # This returns the Endcoded Polyline path.
      #
      # @return [String] Encoded polyline
      def path
        @attributes.fetch('path', nil)
      end

      # This returns an association to the Polyline proxy that
      # can encode and decode the details.
      #
      # @return [Polyline] The Polyline object
      def polyline
        @polyline ||= Automatic::Client::Polyline.new(self.path)
      end

      def distance_in_miles
        (distance_m.to_i * 0.000621371)
      end

      def distance_m
        @attributes.fetch('distance_m', nil)
      end
      alias :distance_in_meters :distance_m

      def hard_accels
        @attributes.fetch('hard_accels', 0)
      end

      def hard_brakes
        @attributes.fetch('hard_brakes', 0)
      end

      def duration_over_80_s
        @attributes.fetch('duration_over_80_s', 0)
      end
      alias :duration_over_80 :duration_over_80_s

      def duration_over_75_s
        @attributes.fetch('duration_over_75_s', 0)
      end
      alias :duration_over_75 :duration_over_75_s

      def duration_over_70_s
        @attributes.fetch('duration_over_70_s', 0)
      end
      alias :duration_over_70 :duration_over_70_s

      def fuel_cost_usd
        @attributes.fetch('fuel_cost_usd', 0)
      end
      alias :fuel_cost :fuel_cost_usd

      def fuel_volume_gal
        @attributes.fetch('fuel_volume_gal', 0)
      end
      alias :fuel_volume :fuel_volume_gal

      def average_mpg
        @attributes.fetch('average_mpg', 0)
      end

      private
      def vehicle_params
        @attributes.fetch('vehicle', {})
      end

      def user_params
        @attributes.fetch('user', {})
      end

      def start_location_params
        @attributes.fetch('start_location', {})
      end

      def end_location_params
        @attributes.fetch('end_location', {})
      end

      def start_time_before_zone
        self.start_time.to_s.extend(Automatic::CoreExtension::Time).from_milliseconds
      end

      def end_time_before_zone
        self.end_time.to_s.extend(Automatic::CoreExtension::Time).from_milliseconds
      end
    end
  end
end
