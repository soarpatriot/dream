class V1::CommentsApi < Grape::API


  before do
    token_authenticate!
  end
  params do
    requires :auth_token, type: String
  end

  resources :comments do


    desc "发表comment", {

    }
    params do
      requires :content, desc: "内容"
    end
    post  do
      comment = Comment.create content:params[:content], user:current_user
      error! comment.errors.full_messages.join(","), 400 unless comment.persisted?
      success_result
    end

  end

end
