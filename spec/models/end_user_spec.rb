require 'rails_helper'

RSpec.describe 'EndUserモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { end_user.valid? }

    let!(:other_end_user) { create(:end_user) }
    let(:end_user) { build(:end_user) }

    context 'nameカラム確認' do
      it '2文字以上であること' do
        end_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '一意性があること' do
        end_user.name = other_end_user.name
        is_expected.to eq false
      end
    end
    context 'emailカラムの確認' do
      it '一意性があること' do
        end_user.email = other_end_user.email
        is_expected.to eq false
      end
      it "メールアドレスのフォーマットの有効性" do
        end_user.email = "endend,com"
        is_expected.to eq false
      end
    end
  end

  describe EndUser do
    context '登録のテスト' do
      it 'すべての項目が入力されていれば登録' do
        end_user = build(:end_user)
        expect(end_user).to be_valid
      end
      it 'emailがない場合は登録できない' do
        end_user = build(:end_user, email: nil)
        expect(end_user).to_not be_valid
      end
      it 'nameがない場合は登録できない' do
        end_user = build(:end_user, name: nil)
        expect(end_user).to_not be_valid
      end
      it 'passwordがない場合は登録できない' do
        end_user = build(:end_user, password: nil)
        expect(end_user).to_not be_valid
      end
      it 'パスワードと確認が一致していないと登録できない' do
        end_user = build(:end_user, password_confirmation: "")
        expect(end_user).to_not be_valid
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