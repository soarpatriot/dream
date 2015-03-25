class V1::PostsApi < Grape::API

  resources :posts do

    desc "获得post list", {
        entity: PostEntity
    }
    params do
      optional :before,type:Integer, desc: "内容"
    end
    get do
      posts = Post.all
      post_page posts, params[:before]
    end
    
    desc "获得单个post ", {
        entity: PostEntity
    }
    params do
      requires :id ,type:Integer, desc: "id"
    end
    get "/:id" do
      post = Post.find(params[:id])
      present post, with: PostEntity
    end



    desc "发表post", {
    }
    params do
      requires :dream , desc: "dream"
      requires :reality, desc: "reality"
      optional :percentage, desc: "finish percentage"
      requires :auth_token, type: String
    end
    post  do
      token_authenticate!
      post = Post.create dream:params[:dream], reality:params[:reality], percentage:params[:percentage], user:current_user
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
   
    desc "获得 diaries list", {
        entity: DiaryEntity
    }
    params do
      requires :id,type:Integer, desc: "id"
      optional :before,type:Integer, desc: "dirary id"
    end
    get ":id/diaries" do
      post = Post.find(params[:id])
      diary_page post.diaries, params[:before]
    end


  end

end
