require 'uri'
require 'ox'

module UPS
  module Parsers
    class TrackParser < BaseParser
      attr_reader :tracking_data

      def identification_number
        shipment[:ShipmentIdentificationNumber]
      end

      def package
        shipment[:Package]
      end

      private

      def shipment
        root_response[:Shipment]
      end

      def root_response
        parsed_response[:TrackResponse]
      end
    end
  end
end
