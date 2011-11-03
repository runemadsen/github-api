require 'github-api'

describe GithubApi::Blob do
   
  describe "to_json" do
    it "should return valid JSON" do
      repo = GithubApi::Blob.new("Some content", "utf-8")
      repo.token.should eql("124234FC7687687SSSCC")
    end
  end
  
end