require 'github-api'

describe GithubApi::User do
   
  describe "new" do
    it "should initialize with token" do
      repo = GithubApi::User.new("124234FC7687687SSSCC")
      repo.token.should eql("124234FC7687687SSSCC")
    end
  end
  
end