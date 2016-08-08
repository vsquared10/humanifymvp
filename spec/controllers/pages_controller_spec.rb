describe PagesController do
  describe 'GET profile' do
    let(:user) { create(:user) }

    it 'assigns the current user' do
      sign_in user
      get :profile
      expect(assigns(:user)).to eq user

      sign_in nil
      get :profile
      expect(assigns(:user)).to eq nil
    end
  end

  describe 'GET about' do
    it 'returns success' do
      get :about
      expect(response).to have_http_status :ok
    end
  end
end
