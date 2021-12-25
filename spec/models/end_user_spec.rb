require 'rails_helper'

RSpec.describe 'EndUserモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { end_user.valid? }

    let!(:other_end_user) { create(:end_user) }
    let(:end_user) { build(:end_user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        end_user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること' do
        end_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '一意性があること' do
        end_user.name = other_end_user.name
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end

end