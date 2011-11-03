Installation
------------

NB: This is a super early version of this gem. Use only for testing purposes

To install the gem, simply run:

    gem install 'github-api'

Or the bundler equivalent:

    bundle install 'github-api'

Examples
--------

Use the gem to create / retrieve Github repo data. You can use my 'github-oauth' gem to get the token.

Use oauth token to create a user object

    @user = GithubApi::User.new(ab3cd9j4ks73hf7)

Then create stuff
    
    @user.has_repo?("my_repo_name")

    repo = @user.create_repo("githunch_bookmarks", {
      :description => "Repository for Githunch Bookmarks",
      :homepage => "http://githunch.heroku.com",
      :public => true,
      :has_issues => false,
      :has_wiki => false,
      :has_downloads => false
    })

    file = GithubApi::Blob.new(:content => "this is my content", :path => "bookmarks.json")
    tree = repo.create_tree([file])

    commit = repo.create_initial_commit(tree.data["sha"], "This is my commit text")

    reference = repo.create_ref("refs/heads/master", commit.data["sha"])

Or retrieve stuff

    blob = repo.ref("heads/master").commit.tree.file("bookmarks.json")
    puts blob.content

   

   