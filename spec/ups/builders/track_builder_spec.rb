require 'spec_helper'

class UPS::Builders::TestTrackBuilder < Minitest::Test
  include SchemaPath
  include ShippingOptions

  def setup
    @track_builder = UPS::Builders::TrackBuilder.new do |builder|
      builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
      builder.add_tracking_number '1ZA2A6940318138649'
    end
  end

  def test_validates_against_xsd
    assert_passes_validation schema_path('TrackRequest.xsd'), @track_builder.to_xml
  end
end
