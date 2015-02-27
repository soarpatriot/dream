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
      optional :image , desc: "图片文件"
      optional :sound, desc: "声音文件"
      optional :content, desc: "内容"
    end
    post  do
      if params[:image].blank? and params[:sound].blank? and params[:content].blank?
        error! "声音，图片，文字至少发表一项", 400
      end
      comment = Comment.create image:params[:image], sound:params[:sound], content:params[:content], user:current_user
      error! comment.errors.full_messages.join(","), 400 unless comment.persisted?
      success_result
    end

  end

end
