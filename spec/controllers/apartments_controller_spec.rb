require 'rails_helper'

RSpec.describe ApartmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:apartment) { create(:apartment, user: user) }
  let(:valid_attributes) { attributes_for(:apartment) }
  let(:invalid_attributes) { attributes_for(:apartment, price: nil) }

  describe 'GET #index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @apartments' do
      apartments = create_list(:apartment, 3)
      expect(assigns(:apartments)).to match_array(apartments)
    end

    context 'with filters' do
      it 'filters by price' do
        get :index, params: { sort: 'price_desc' }
        expect(response).to have_http_status(:success)
      end

      it 'filters by bedrooms' do
        get :index, params: { bedrooms: 2 }
        expect(response).to have_http_status(:success)
      end

      it 'filters by type' do
        get :index, params: { type: 'apartment' }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: apartment.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns @apartment' do
      expect(assigns(:apartment)).to eq(apartment)
    end
  end

  describe 'GET #new' do
    context 'when user is signed in' do
      before do
        sign_in user
        get :new
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns a new apartment' do
        expect(assigns(:apartment)).to be_a_new(Apartment)
      end
    end

    context 'when user is not signed in' do
      before { get :new }

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid params' do
        it 'creates a new apartment' do
          expect do
            post :create, params: { apartment: valid_attributes }
          end.to change(Apartment, :count).by(1)
        end

        it 'redirects to the created apartment' do
          post :create, params: { apartment: valid_attributes }
          expect(response).to redirect_to(Apartment.last)
        end
      end

      context 'with invalid params' do
        it 'does not create a new apartment' do
          expect do
            post :create, params: { apartment: invalid_attributes }
          end.not_to change(Apartment, :count)
        end

        it 're-renders the new template' do
          post :create, params: { apartment: invalid_attributes }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        post :create, params: { apartment: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'when user owns the apartment' do
        before { get :edit, params: { id: apartment.id } }

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'assigns the requested apartment' do
          expect(assigns(:apartment)).to eq(apartment)
        end
      end

      context 'when user does not own the apartment' do
        let(:other_apartment) { create(:apartment) }

        it 'redirects to root path' do
          get :edit, params: { id: other_apartment.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        get :edit, params: { id: apartment.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'when user owns the apartment' do
        context 'with valid params' do
          let(:new_attributes) { { price: 2000 } }

          it 'updates the requested apartment' do
            patch :update, params: { id: apartment.id, apartment: new_attributes }
            apartment.reload
            expect(apartment.price).to eq(2000)
          end

          it 'redirects to the apartment' do
            patch :update, params: { id: apartment.id, apartment: new_attributes }
            expect(response).to redirect_to(apartment)
          end
        end

        context 'with invalid params' do
          it 're-renders the edit template' do
            patch :update, params: { id: apartment.id, apartment: invalid_attributes }
            expect(response).to render_template(:edit)
          end
        end
      end

      context 'when user does not own the apartment' do
        let(:other_apartment) { create(:apartment) }

        it 'redirects to root path' do
          patch :update, params: { id: other_apartment.id, apartment: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        patch :update, params: { id: apartment.id, apartment: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'when user owns the apartment' do
        it 'destroys the requested apartment' do
          apartment # Create the apartment
          expect do
            delete :destroy, params: { id: apartment.id }
          end.to change(Apartment, :count).by(-1)
        end

        it 'redirects to the apartments list' do
          delete :destroy, params: { id: apartment.id }
          expect(response).to redirect_to(apartments_url)
        end
      end

      context 'when user does not own the apartment' do
        let(:other_apartment) { create(:apartment) }

        it 'does not destroy the apartment' do
          other_apartment # Create the apartment
          expect do
            delete :destroy, params: { id: other_apartment.id }
          end.not_to change(Apartment, :count)
        end

        it 'redirects to root path' do
          delete :destroy, params: { id: other_apartment.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in page' do
        delete :destroy, params: { id: apartment.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
