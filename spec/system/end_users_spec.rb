require 'rails_helper'

describe 'End userの登録' do
  describe 'createアクション' do
    it '全てのカラムに入力があると登録できる' do
      end_user = build(:end_user)
      expect(end_user).to be_valid
    end
    it 'nameカラムに入力がないと登録できない' do
  end
  
  
end