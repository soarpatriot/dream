require "grape-swagger"
class ApiV1 < Grape::API

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :put, :post, :options, :delete]
    end
  end

  include Grape::Kaminari
  version :v1
  format :json
  paginate per_page: 15

  before do
    I18n.locale = "zh-CN"
  end

  get do
    {
        name: "v1"
    }
  end

  helpers PostHelper
  helpers CommentHelper
  helpers DiaryHelper
  helpers AccessHelper
  helpers LocaleHelper
  helpers ApplicationHelper
 

  mount V1::UserApi
  mount V1::PostsApi
  mount V1::CommentsApi
  mount V1::DiariesApi
  mount V1::VotesApi
  add_swagger_documentation  api_version:"v1", base_path: Settings.host
  # http://api.dreamreality.cn/v1/swagger_doc.json   
  #add_swagger_documentation
  # add_swagger_documentation api_version: "v1", markdown: true
  # add_swagger_documentation api_version: "v2", markdown: true
end
