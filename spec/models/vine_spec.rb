require 'spec_helper'

describe Vine do
  before do
    @user = FactoryGirl.create(:user)
    @vine = FactoryGirl.create(:vine_one, user_id: @user.id)
  end

  it "should have a unique video_url" do
    expect {
      FactoryGirl.create(:vine_one, user_id: @user.id)
    }.to raise_error ActiveRecord::RecordInvalid
  end

  it "should not be created without belonging to a user" do
    expect {
      FactoryGirl.create(:vine_two)
    }.to raise_error ActiveRecord::RecordInvalid
  end
end
