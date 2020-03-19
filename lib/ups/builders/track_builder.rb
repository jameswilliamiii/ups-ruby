require 'ox'

module UPS
  module Builders
    # The {TrackBuilder} class builds UPS XML Track Objects.
    #
    # @author James Stubblefield
    # @since TBD
    class TrackBuilder < BuilderBase
      include Ox

      # Initializes a new {TrackBuilder} object
      #
      def initialize
        super 'TrackRequest'

        # add_request('Track', 'activity') do |request|
        #   request << add_transaction_reference
        # end

        add_request('Track', 'activity')
      end

      # Adds a TrackingNumber section to the XML document being built
      #
      # @param [String] tracking_number The UPS tracking number
      # @return [void]
      def add_tracking_number(tracking_number)
        root << element_with_value('TrackingNumber', tracking_number)
      end

      private

      def add_transaction_reference
        Element.new('TransactionReference').tap do |trans_ref|
          trans_ref << element_with_value('CustomerContext', 'Tracking')
          trans_ref << element_with_value('XpciVersion', '1.0')
        end
      end
    end
  end
end
