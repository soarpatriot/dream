require "spec_helper"

describe V1::CommentsApi do

  let(:comment_path) { "/v1/comments" }


  context "create a post" do

    it "fail" do
      res = auth_json_post comment_path
      expect(res[:error]).to eq("声音，图片，文字至少发表一项")
    end

    it "succes" do
      image = File.open("#{G2.config.root_dir}/app/assets/images/day3.jpg")
      sound = File.open("#{G2.config.root_dir}/app/assets/sound/xiatian.mp3")
      res = auth_json_post comment_path, content:"sss", image:image, sound:sound
      expect(res[:code]).to eq(0)
    end

  end



end
