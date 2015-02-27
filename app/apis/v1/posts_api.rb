class V1::PostsApi < Grape::API


  before do
    token_authenticate!
  end
  params do
    requires :auth_token, type: String
  end

  resources :posts do

    desc "获得sound list", {
        entity: PostEntity
    }
    params do
      optional :before,type:Integer, desc: "内容"
    end
    get do
      posts = Post.all
      post_page posts, params[:before]
    end


    desc "上传声音", {

    }
    params do
      requires :image , desc: "图片文件"
      requires :sound, desc: "声音文件"
      optional :content, desc: "内容"
    end
    post  do
      post = Post.create image:params[:image], sound:params[:sound], content:params[:content], user:current_user
      error! post.errors.full_messages.join(","), 400 unless post.persisted?
      success_result
    end

    desc "获得 comments list", {
        entity: CommentEntity
    }
    params do
      requires :id,type:Integer, desc: "id"
      optional :before,type:Integer, desc: "comment id"
    end
    get ":id/comments" do
      post = Post.find(params[:id])
      comment_page post.comments, params[:before]
    end

  end

end
