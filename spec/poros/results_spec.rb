require './i-scream-arcade-microservice-app'
require 'rack/test'


RSpec.describe IScreamMicroservice do
  include Rack::Test::Methods
  def app
    IScreamMicroservice.new # this defines the active application for this test
  end

  it "generate ids" do
    results = GameResults.new 

    ids = results.generate_ids(['4235', '8972'])
    expect(ids).to eq([4235,8972])
  end
end