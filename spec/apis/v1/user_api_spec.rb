require "spec_helper"

describe V1::UserApi do

  let(:login_path) { "/v1/user/login" }
  let(:register_path) { "/v1/user/register" }
  let(:update_profile_path) { "/v1/user/update_profile" }
  
  def user_posts_path user 
    "/v1/user/#{user.id}/posts"
  end
  def user_profile_path user
    "v1/user/#{user.id}/profile"
  end 

  context "register" do
    it "fails without mobile_number or password or register_code or nickname" do
      res = json_post register_path
      expect(res[:error]).to eq("mobile_number is missing, name is missing, password is missing")
    end

    it "succes" do
      res = json_post register_path, name:"aaa", password:"bbb", mobile_number:"18603331140"
      expect(res[:name]).to eq("aaa")
    end

  end
  
  context "update profile" do
    it "get user profile" do 
       user = create :user 
       res = json_get user_profile_path user 
       expect(res[:id]).to eq user.id       
    end
  end

  context "update profile" do

    it "succes" do
      image = File.open("#{G2.config.root_dir}/app/assets/images/day3.jpg")
      user = create :user, name:"aa",password:"bb"
      name = "bb"
      auth_token = create :auth_token, user: user 
      res = data_post update_profile_path, auth_token:auth_token.value, avatar: image ,name:name
      
      user0 = user.reload

      user1 = User.where(name:"aa").first
     
      expect(user1).to eq(nil)
      expect(user0.name).to eq(name)
      expect(res.status).to eq(201)
    end

  end


  context "login" do
    it "fail" do
      user = create :user
      res = json_post login_path, mobile_number:user.mobile_number, password:121
      expect(res[:error]).to eq(I18n.t("password_not_correct"))
    end
    it "user not exist" do
      user = create :user
      res = json_post login_path, mobile_number:"123123", password:121
      expect(res[:error]).to eq(I18n.t("user_not_exist"))
    end
    it "success" do
      user = create :user
      res = json_post login_path, mobile_number:user.mobile_number, password:user.password
      expect(res[:name]).to eq(user.name)
    end
  end
 
  context "user posts" do 
    it "list" do 
      user = create :user
      posts = create_list :post, 10, user: user
      res = json_get user_posts_path(user)
      expect(res[:data].size).to eq(2)
      expect(res[:has_more]).to eq(true)
    end
   
    it "before" do 
      user = create :user
      posts = create_list :post, 2, user: user
      post = create :post, user: user
      res = json_get user_posts_path(user), before: post.id
      expect(res[:data].size).to eq(2)
      expect(res[:has_more]).to eq(false)
    end
 
  end

end
