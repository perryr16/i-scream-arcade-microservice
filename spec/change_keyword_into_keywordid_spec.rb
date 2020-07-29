require './i-scream-arcade-microservice-app'
require 'rack/test'

RSpec.describe IScreamMicroservice do
  include Rack::Test::Methods
  def app
    IScreamMicroservice.new # this defines the active application for this test
  end

  it "change keyword to keyword id" do 
    get '/keyword_to_keyid/lifesimulator'

    expect(last_response.body).to include(43)
  end
end