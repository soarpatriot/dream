require "spec_helper"

describe V1::PostsApi do

  let(:post_path) { "/v1/posts" }
  
  def get_post_path post
    "/v1/posts/#{post.id}"
  end
  

  def comments_path post
    "/v1/posts/#{post.id}/comments"
  end
  
  def diaries_path post
    "/v1/posts/#{post.id}/diaries"
  end



  context "create a post" do

    it "fail" do
      res = auth_json_post post_path, content:"sss"
      expect(res[:error]).to eq("dream is missing, reality is missing")
    end

    it "succes" do
      dream = "test"
      reality = "test"      
      res = auth_json_post post_path, percentage:20, dream:dream, reality:reality
      expect(res[:code]).to eq(0)
    end

  end
  
  context "get a post" do

    it "succes" do
      
      dream = "test"
      reality = "test"      

      post = create :post, dream: dream, reality: reality 
      res = json_get get_post_path(post)
      expect(res[:dream]).to eq(dream)
    end

  end


  context "posts list" do

    it "list more page" do
      create_list :post, 4

      res = auth_json_get post_path

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list one page" do
      create_list :post, 1

      res = json_get post_path

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end

    it "list before " do
      create_list :post, 3
      post = create :post
      res = json_get post_path, before: post.id

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list before no more " do
      create_list :post, 1
      post = create :post
      res = json_get post_path, before: post.id

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end
    
    it "list voted " do
      post1 = create :post
      create_list :post, 1
      post = create :post
      user = create :user 
      post.up_by user     
      post1.up_by user     
      auth_token = create :auth_token, user:user
      res = json_get post_path,auth_token: auth_token.value
      
      expect(res[:data][0][:voted]).to eq(true)
      expect(res[:data][1][:voted]).to eq(false)
    end
 
  end


  context "comments list" do

    it "list more page" do
      post = create :post
      create_list :comment, 10, post:post
      res = json_get comments_path(post)

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before" do
      post = create :post
      create_list :comment, 10, post:post
      comment = create :comment, post:post
      res = json_get comments_path(post), before: comment.id

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before only one" do
      post = create :post
      create_list :comment, 1, post:post
      comment = create :comment, post:post
      res = json_get comments_path(post), before: comment.id

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end
  end

  context "diaries list" do

    it "list more page" do
      post = create :post
      create_list :diary, 10, post:post,user:current_user
      res = json_get diaries_path(post)

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before" do
      post = create :post
      create_list :diary, 10, post:post,user:current_user
      diary = create :diary, post:post,user:current_user
      res = json_get diaries_path(post), before: diary.id

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before only one" do
      post = create :post
      create_list :diary, 1, post:post,user:current_user
      diary = create :diary, post:post,user:current_user
      res = json_get diaries_path(post), before: diary.id

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end
  end


end
