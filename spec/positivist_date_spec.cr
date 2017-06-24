require "spec-kemal"
require "./spec_helper"

describe PositivistDate do
  it "translates a date" do
    get "/"
    response.body.includes?(Time.now.year.to_s - 1788).should eq true
  end

  it "translates a given date" do
    get "/?date=2017-6-24"
    response.body.should eq "Sunday, Charlemagne 7, 229"
  end
end
