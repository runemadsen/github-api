module GithubApi
class User
  
  attr_accessor :data, :token
  
  def initialize(token)
    @token = token
    @data = GithubApi::HTTP.get("/user", :query => {:access_token => @token})
    @repos = []
  end
  
  def has_repo?(name)
    load_repos if @repos.empty?
    @repos.find { |repo| repo.name == name }
  end
  
  def repos
    load_repos if @repos.empty?
    @repos
  end
  
  def load_repos
    response = GithubApi::HTTP.get("/user/repos", :query => {:access_token => @token}).parsed_response
    response.each do |repo|
      @repos << Repo.new(self, repo)
    end
  end
  
  def create_repo(name, params)
    body = {:name => name}.merge(params)
    
    response = GithubApi::HTTP.post("/user/repos", 
      :query => { :access_token => @token},
      :body => body.to_json
    ).parsed_response
    
    @repos << Repo.new(self, response)
    @repos.last
  end
  
  def repo(name)
    load_repos if @repos.empty?
    @repos.find { |repo| repo.name == name }
  end
  
end
end