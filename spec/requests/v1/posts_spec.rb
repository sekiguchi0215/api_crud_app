require "rails_helper"

RSpec.describe "V1::Posts", type: :request do
  describe "GET #index" do
    context "投稿が存在するとき" do
      subject { get(v1_posts_path) }
      before { create_list(:post, 3) }

      it "投稿一覧を取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq 3
        expect(json[0].keys).to eq ["id", "title", "content"]
        expect(json[0]["id"]).to eq Post.first.id
        expect(json[0]["title"]).to eq Post.first.title
        expect(json[0]["content"]).to eq Post.first.content
      end
    end
  end

  describe "GET #show" do
    subject { get(v1_post_path(post_id)) }

    context "指定したidの投稿が存在する時" do
      let(:post) { create(:post) }
      let(:post_id) { post.id }

      it "指定したidの投稿を取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json["title"]).to eq post.title
        expect(json["content"]).to eq post.content
      end
    end

    context "指定したの投稿が存在しない時" do
      let(:post_id) { 0 }
      it "エラーが発生すること" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST #create" do
  end

  describe "PATCH #update" do
  end

  describe "DELETE #destroy" do
  end
end
