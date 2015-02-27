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

  end

end
