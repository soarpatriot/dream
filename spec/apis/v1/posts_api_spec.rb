require "spec_helper"

describe V1::PostsApi do

  let(:post_path) { "/v1/posts" }
  def comments_path post
    "/v1/posts/#{post.id}/comments"
  end


  context "create a post" do

    it "fail" do
      res = auth_json_post post_path, content:"sss"
      expect(res[:error]).to eq("image is missing, sound is missing")
    end

    it "succes" do
      image = File.open("#{G2.config.root_dir}/app/assets/images/day3.jpg")
      sound = File.open("#{G2.config.root_dir}/app/assets/sound/xiatian.mp3")
      res = auth_json_post post_path, content:"sss", image:image, sound:sound
      expect(res[:code]).to eq(0)
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

      res = auth_json_get post_path

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end

    it "list before " do
      create_list :post, 3
      post = create :post
      res = auth_json_get post_path, before: post.id

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list before no more " do
      create_list :post, 1
      post = create :post
      res = auth_json_get post_path, before: post.id

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end
  end


  context "comments list" do

    it "list more page" do
      post = create :post
      create_list :comment, 10, post:post
      res = auth_json_get comments_path(post)

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before" do
      post = create :post
      create_list :comment, 10, post:post
      comment = create :comment, post:post
      res = auth_json_get comments_path(post), before: comment.id

      expect(res[:has_more]).to eq(true)
      expect(res[:data].size).to eq(2)
    end

    it "list more page, before only one" do
      post = create :post
      create_list :comment, 1, post:post
      comment = create :comment, post:post
      res = auth_json_get comments_path(post), before: comment.id

      expect(res[:has_more]).to eq(false)
      expect(res[:data].size).to eq(1)
    end
  end

end
