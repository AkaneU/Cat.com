require 'rails_helper'

RSpec.describe 'Post_commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:end_user) { create(:end_user) }
    let(:post) { build(:post, end_user_id: end_user.id) }
    let!(:post_comment) { build(:post_comment, post_id: post.id, end_user_id: end_user.id) }

    context 'textカラム' do
      it '空欄でないこと' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 201文字は×' do
        post_comment.comment = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'EndUserモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end