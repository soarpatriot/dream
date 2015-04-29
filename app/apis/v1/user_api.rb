class V1::UserApi < Grape::API

  namespace :user do

    desc "用户注册", {
      entity: UserEntity
    }
    params do
      requires :name, type: String
      requires :password, type: String
    end
    post "register" do
      user = User.where(name: params[:name]).first
      locale_error! "user_exsisted", 400 unless user.nil?

      user = User.create name: params[:name], password: params[:password]
      error! user.errors.full_messages.join(","), 400 unless user.persisted?

      success_result
    end
    
    
    desc "更新用户信息", {
      entity: UserEntity
    }
    params do
      requires :avatar
      requires :auth_token, type: String
    end
    post "update_profile" do
      token_authenticate!
      user_params = {}
      user_params[:avatar] = params[:avatar]
      
      current_user.update! user_params
      
    end
    


    desc "用户登陆", {
      entity: UserEntity
    }
    params do
      requires :name, type: String
      requires :password,      type: String
    end
    post "login" do
      user = User.where(name: params[:name]).first

      locale_error! "user_not_exist", 401 unless user

      res = user.authenticate params[:password]
      locale_error! "password_not_correct", 401 unless res

      if res.auth_token.nil?
        res.update auth_token: AuthToken.create
      end

      present res, with: UserEntity, token: res.auth_token.value
    end

    desc "用户退出"
    params do
      requires :auth_token, type: String
    end
    delete "logout" do
      token_authenticate!
    end


    desc "list post"
    params do
      requires :id, type: Integer
      optional :before,type:Integer, desc: "post id"
    end
    get ":id/posts" do
      user = User.find(params[:id])
      posts = user.posts
      post_page posts, params[:before]
            
    end

  end
end
