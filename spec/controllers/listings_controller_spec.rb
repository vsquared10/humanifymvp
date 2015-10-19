require 'rails_helper'

describe ListingsController do
  describe '#index' do
    context 'with an guest user' do
      before { sign_in nil }

      it 'responds with a 200' do
        sign_in nil
        get :index
        expect(response).to have_http_status :ok
      end
    end
  end
end
