require "spec_helper"

describe V1::VotesApi do

 
  def up_path post
    "/v1/votes/#{post.id}/up"
  end
  
  def diaries_path post
    "/v1/posts/#{post.id}/diaries"
  end



  context "up" do
    it "succes" do
      post = create :post
      res = auth_json_post up_path(post), post_id: post.id 
      votes_size = post.votes_for.size 
      expect(votes_size).to eq(1)
    end

  end

end
