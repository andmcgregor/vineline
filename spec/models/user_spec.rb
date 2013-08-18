require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "has a valid factory" do
    @user.should be_valid
  end

  it "validates username for uniqueness" do 
    expect { FactoryGirl.create(:user) }.to raise_error ActiveRecord::RecordInvalid
  end

  context "vines" do
    before do
      @vine_one = FactoryGirl.create(:vine_one, user_id: @user.id)
      @vine_two = FactoryGirl.create(:vine_two, user_id: @user.id)
    end

    it "are ordered by date filmed" do
      @user.vines.should eq [@vine_two, @vine_one]
    end

    it "are destroyed when user is destroyed" do
      expect { @user.destroy }.to change { Vine.count }.by(-2)
    end
  end

  it "finds an existing user" do
    User.from_omniauth({
      "provider" => "twitter",
      "uid" => "1",
      "credentials" => {
        "token" => "12345",
        "secret" => "12345"
      }
    }).should eq @user
  end

  it "creates a non-existing user" do
    expect { User.from_omniauth({
      "provider" => "twitter",
      "uid" => "2",
      "credentials" => {
        "token" => "12345",
        "secret" => "12345"
      },
      "info" => {
        "nickname" => "non_existing_user",
        "name" => "Example User",
        "location" => "Example Location",
        "image" => "http://example.com/example_normal.jpg",
        "description" => "Example Description"
      }
    }) }.to change { User.count }.by(1)
  end
end
