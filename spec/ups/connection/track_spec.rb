require 'spec_helper'

describe UPS::Connection do

  before do
    Excon.defaults[:mock] = true
  end

  after do
    Excon.stubs.clear
  end

  let(:stub_path) { File.expand_path("../../../stubs", __FILE__) }
  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting tracking" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when UPS::Connection::TRACK_PATH
          {body: File.read("#{stub_path}/track_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.track do |track_builder|
        track_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        track_builder.add_tracking_number('111111111111')
      end
    end

    it "should return tracking information" do
      expect(subject.identification_number).wont_be_empty
      expect(subject.package).wont_be_empty
    end
  end
end
