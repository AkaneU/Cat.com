require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:end_user) { create(:end_user) }
    let!(:post) { build(:post, end_user_id: end_user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 51文字は×' do
        post.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'textカラム' do
      it '空欄でないこと' do
        post.text = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 201文字は×' do
        post.text = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'EndUserモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
  end
end