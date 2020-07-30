require './i-scream-arcade-microservice-app'
require 'rack/test'

RSpec.xdescribe IScreamMicroservice do
  include Rack::Test::Methods
  def app
    IScreamMicroservice.new # this defines the active application for this test
  end

  it "keyword search" do 
    get '/games_by_keyids/43'

    expect(last_response.body).to include("life simulator")
  end
end