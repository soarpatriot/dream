class CommentEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :user_id,        documentation: {required: true, type: "Integer", desc:"user id"}
  expose :image, documentation: {required: true, type: "String", desc:"image url"}
  expose :sound, documentation: {required: true, type: "String", desc:"sound url"}
  expose :content, documentation: {required: true, type: "String", desc:"文字内容"}
  expose :created_at,     documentation: {required: true, type: "String", desc: "创建时间"}
end
