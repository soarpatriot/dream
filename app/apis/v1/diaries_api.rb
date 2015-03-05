class V1::DiariesApi < Grape::API


  before do
    token_authenticate!
  end
  params do
    requires :auth_token, type: String
  end

  resources :diaries do


    desc "发表日记", {

    }
    params do
      requires :content,type:String, desc: "内容"
      requires :post_id,type:Integer, desc: "内容"
    end
    post  do
      post = Post.find(params[:post_id])
      diary = Diary.create content:params[:content], user:current_user, post: post
      error! diary.errors.full_messages.join(","), 400 unless diary.persisted?
      success_result
    end

  end

end
