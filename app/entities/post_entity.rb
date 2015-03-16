class PostEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :user_id,        documentation: {required: true, type: "Integer", desc:"user id"}
  expose :dream, documentation: {required: true, type: "String", desc:"image url"}
  expose :reality, documentation: {required: true, type: "String", desc:"sound url"}
  expose :percentage, documentation: {required: true, type: "String", desc:"文字内容"}
  expose :created_at,       documentation: {required: true, type: "Integer", desc: "创建时间"} do |instance|
       instance.created_at.to_i
  end
  
end
