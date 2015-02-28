require "spec_helper"

describe V1::CommentsApi do

  let(:comment_path) { "/v1/comments" }


  context "create a post" do

    it "fail" do
      res = auth_json_post comment_path
      expect(res[:error]).to eq("content is missing")
    end

    it "succes" do
      res = auth_json_post comment_path, content:"sss"
      expect(res[:code]).to eq(0)
    end

  end



end
