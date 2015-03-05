require "spec_helper"

describe V1::DiariesApi do

  let(:diary_path) { "/v1/diaries" }


  context "create a diary" do

    it "fail" do
      res = auth_json_post diary_path
      expect(res[:error]).to eq("content is missing, post_id is missing")
    end

    it "succes" do
      
      post = create :post
      res = auth_json_post diary_path, content:"sss", post_id:post.id
      expect(res[:code]).to eq(0)
    end

  end



end
