module GithubApi
class Repo
  
  attr_accessor :data, :name
  
  def initialize(user, data)
    @user = user
    @data = data
    @name = data["name"]
    @trees = []
    @commits = []
    @refs = []
    @blobs = []
  end
  
  #   Trees
  # ------------------------------------------------------------------------------
  
  def tree(sha)
    puts "SHA: #{sha}"
    # TODO: it may be smart to just load all trees at one time
    tre = @trees.find { |t| t.data["sha"] == sha }
    if tre.nil?
      response = GithubApi::HTTP.get("/repos/#{@user.data['login']}/#{@name}/git/trees/" + sha).parsed_response
      tre = GithubApi::Tree.new(self, response)
      @trees << tre
    end
    tre
  end
  
  def create_tree(blobs)
    # TODO: Check if blobs have path names in them. It is required
    # Throw error if not
    response = GithubApi::HTTP.post("/repos/#{@user.data['login']}/#{@name}/git/trees", 
      :query => {
        :access_token => @user.token
      },
      :body => {
        :tree => blobs.map { |blob| blob.to_hash }
      }.to_json
    ).parsed_response
    
    @trees << Tree.new(self, response)
    @trees.last
  end
  
  #   Commits
  # ------------------------------------------------------------------------------
  
  def commit(sha)
    # TODO: it may be smart to just load all commits at one time
    com = @commits.find { |c| c.data["sha"] == sha }
    if com.nil?
      response = GithubApi::HTTP.get("/repos/#{@user.data['login']}/#{@name}/git/commits/" + sha).parsed_response
      com = GithubApi::Commit.new(self, response)
      @commits << com
    end
    com
  end
  
  def create_initial_commit(sha, message)
    response = GithubApi::HTTP.post("/repos/#{@user.data['login']}/#{@name}/git/commits", 
      :query => {
        :access_token => @user.token
      },
      :body => {
        :message => message,
        :tree => sha
      }.to_json
    ).parsed_response
    
    @commits << GithubApi::Commit.new(self, response)
    @commits.last
  end
  
  #   References
  # ------------------------------------------------------------------------------
  
  def ref(name)
    # TODO: it may be smart to just load all refs at one time
    reference = @refs.find { |r| r.data["ref"] == name }
    if reference.nil?
      response = GithubApi::HTTP.get("/repos/#{@user.data['login']}/#{@name}/git/refs/" + name).parsed_response
      reference = GithubApi::Reference.new(self, response)
      @refs << reference
    end
    reference
  end
  
  def create_ref(name, sha)
    response = GithubApi::HTTP.post("/repos/#{@user.data['login']}/#{@name}/git/refs", 
      :query => {
        :access_token => @user.token
      },
      :body => {
        :ref => name,
        :sha => sha
      }.to_json
    ).parsed_response
    
    @refs << GithubApi::Reference.new(self, response)
    @refs.last
  end
  
  #   Blobs
  # ------------------------------------------------------------------------------
  
  def blob(sha)
    # TODO: it may be smart to just load all blobs at one time
    blo = @blobs.find { |b| b.data["sha"] == sha }
    if blo.nil?
      response = GithubApi::HTTP.get("/repos/#{@user.data['login']}/#{@name}/git/blobs/" + sha,
        :headers => {
          'Content-Type' => 'application/vnd.github.beta.raw' 
        }
      ).parsed_response
      blo = GithubApi::Blob.new(response)
      @blobs << blo
    end
    blo
  end
  
end
end