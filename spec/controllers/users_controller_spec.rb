RSpec.describe UsersController, type: :controller do
  include Warden::Test::Helpers
  include Devise::Test::ControllerHelpers
  let(:valid_attributes) do
    { user: { email: 'c2nptech@gmail.com', password: '123456' } }
  end

  describe 'POST #create' do
    context 'When param valid' do
      it 'returns a success response' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq('You have been access successfully!')
      end
    end

    context 'When email is blank' do
      it 'returns a error response' do
        valid_attributes[:user][:email] = nil
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq('Invalid email or password. Please try again!')
      end
    end

    context 'When email not correct format' do
      it 'returns a error response' do
        valid_attributes[:user][:email] = 'abcd.cn'
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq('Invalid email or password. Please try again!')
      end
    end

    context 'When password is blank' do
      it 'returns a error response' do
        valid_attributes[:user][:password] = ''
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq('Invalid email or password. Please try again!')
      end
    end

    context 'When password to short' do
      it 'returns a error response' do
        valid_attributes[:user][:password] = '111'
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq('Invalid email or password. Please try again!')
      end
    end

    xcontext 'when password and password_confirmation not match' do
      # TODO: here
    end

    xcontext 'when exist email but password wrong' do
      # TODO: here
    end
  end
end
