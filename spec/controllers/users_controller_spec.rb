describe UsersController do
  describe 'GET show' do
    let(:user) { create(:user) }

    it 'should find the user' do
      get :show, id: user.id, name: user.name
      expect(assigns(:user)).to eq user
    end
  end
end
