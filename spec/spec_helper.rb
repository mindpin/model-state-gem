require "rspec"
require 'rspec/its'
require "model-state"
require "pry"
ENV["MONGOID_ENV"] = "test"
Mongoid.load!("./spec/mongoid.yml")

class Dummy
  include Mongoid::Document
  include ModelState

  add_state :state,
            :states  => [:s1, :s2],
            :default => :s1
end

RSpec.configure do |config|
  config.after(:each) do
    Mongoid.purge!
  end
end
