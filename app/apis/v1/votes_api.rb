class V1::VotesApi < Grape::API

  before do
    token_authenticate!
  end
  params do
    requires :auth_token, type: String
  end

  resources :votes do

    desc "up", {
    }
    params do
      requires :post_id, type: String
    end
    post ":id/up" do
      post = Post.find(params[:post_id])
      post.up_by current_user     
      post
    end
  end
end
