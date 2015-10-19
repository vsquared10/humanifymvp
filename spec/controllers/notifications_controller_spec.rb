require 'rails_helper'

describe NotificationsController do
  describe '#index' do
    context 'with a guest user' do
      before { sign_in nil }

      it 'redirects to the login route' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with an authed user' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'renders user notifications' do
        get :index
        expect(response.body).to eq [].to_s
      end
    end
  end
end
