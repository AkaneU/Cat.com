require 'rails_helper'

RSpec.describe 'Inquiryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { inquiry.valid? }

    let(:end_user) { build(:end_user) }
    let!(:inquiry) { build(:inquiry, end_user_id: end_user.id) }

    context 'nameカラム確認' do
      it '空欄でないこと' do
        inquiry.name = ""
        is_expected.to eq false
      end
    end
    context 'emailカラムの確認' do
      it '空欄でないこと' do
        inquiry.email = ""
        is_expected.to eq false
      end
      it "メールアドレスのフォーマットの有効性" do
        inquiry.email = "endend,com"
        is_expected.to eq false
      end
    end
    context 'titleカラムの確認' do
      it '空欄でないこと' do
        inquiry.title = ""
        is_expected.to eq false
      end
    end
    context 'textカラムの確認' do
      it '空欄でないこと' do
        inquiry.text = ""
        is_expected.to eq false
      end
    end
  end

  describe Inquiry do
    context '問い合わせのテスト' do
      it 'すべての項目が入力されていれば送信' do
        inquiry = build(:inquiry)
        expect(inquiry).to be_valid
      end
      it 'emailがない場合は送信できない' do
        inquiry = build(:inquiry, email: nil)
        expect(inquiry).to_not be_valid
      end
      it 'nameがない場合は送信できない' do
        inquiry = build(:inquiry, name: nil)
        expect(inquiry).to_not be_valid
      end
      it 'titleがない場合は送信できない' do
        inquiry = build(:inquiry, title: nil)
        expect(inquiry).to_not be_valid
      end
      it 'textがない場合は送信できない' do
        inquiry = build(:inquiry, text: nil)
        expect(inquiry).to_not be_valid
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'EndUserモデルとの関係' do
      it 'N:1となっている' do
        expect(Inquiry.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
  end

end