RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'Register new user' do
    context 'When email and password valid' do
      it 'user was register valid' do
        expect(@user).to be_valid
      end

      it 'user was register sucess with password has 6 charactor' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end
    end
  end

  context 'When email null' do
    it 'register not success' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Email can\'t be blank')
    end
  end

  context 'When email not correct format' do
    it 'register not success' do
      @user.email = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
  end

  context 'When password is not match' do
    it 'register not success' do
      @user.password = '222223'
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end
  end

  context 'When password is too short' do
    it 'register not success' do
      @user.password = '11'
      @user.password_confirmation = '11'
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Password is too short (minimum is 6 characters)"])
    end
  end

  context 'When password is nil' do
    it 'register not success' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to eq(["Password can't be blank"])
    end
  end
end
