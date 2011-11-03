module GithubApi
  
  # TODO: Generally there's a problem with accessing data via data["sha"]. Find a way to streamline this to: commit.sha
  # TODO: Repo JSON is different when creating, getting all or getting one. Find a way to merge this

  #  HTTP class
  # -------------------------------------

  class HTTP
    include HTTParty
    format :json
    base_uri 'https://api.github.com'
  end
  
  #  Reference class
  # -------------------------------------
  
  class Reference
    
    attr_accessor :repo, :data
    
    def initialize(repo, data)
      @repo = repo
      @data = data
    end
    
    def commit
      # TODO: Object in ref is not always a commit.
      @repo.commit(data["object"]["sha"])
    end
    
  end
  
  #  Commit class
  # -------------------------------------
  
  class Commit
    
    attr_accessor :repo, :data
    
    def initialize(repo, data)
      @repo = repo
      @data = data
    end
    
    def tree
      @repo.tree(data["tree"]["sha"])
    end
    
  end
  
  #  Tree class
  # -------------------------------------
  
  class Tree
    
    attr_accessor :repo, :data
    
    def initialize(repo, data)
      @repo = repo
      @data = data
    end
    
    def file(path)
      blob_ref = data["tree"].find { |b| b["path"] == path}
      unless blob_ref.nil?
        sha = blob_ref["sha"]
        @repo.blob(sha)
      else
        # throw error because the blob is not there
      end
    end
    
  end
  
  #  Blob class
  # -------------------------------------
  
  class Blob
    
    attr_accessor :content, :encoding, :path
    
    def initialize(attributes={}) 
      @encoding = "utf-8"
      attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
    end
    
    def to_hash
      {
        :type => "blob",
        :path => @path,
        :content => @content,
        :encoding => @encoding
      }
    end
    
  end
  
end