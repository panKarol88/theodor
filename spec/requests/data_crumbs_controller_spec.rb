# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DataCrumbsController' do
  let(:warehouse) { create(:warehouse, name: Faker::Number.number(digits: 10).to_s) }

  describe 'authorized', :authorized do
    let(:authenticated_user) { create(:user) }
    let(:valid_attributes) { { content: 'Valid content', warehouse_id: warehouse.id } }
    let(:invalid_attributes) { { content: '' } }

    before { authenticated_user.warehouses << warehouse }

    describe 'POST /data_crumbs' do
      context 'with valid parameters' do
        let(:action) { post '/data_crumbs', params: { data_crumb: valid_attributes } }

        it 'creates a new DataCrumb' do
          expect { action }.to change(DataCrumb, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        let(:action) { post '/data_crumbs', params: { data_crumb: invalid_attributes } }

        it 'does not create a new DataCrumb' do
          expect { action }.not_to change(DataCrumb, :count)
        end

        it "renders the 'new' template" do
          action
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT /data_crumbs/:id' do
      let(:data_crumb) { create(:data_crumb, content: 'Valid content', warehouse:) }

      context 'with valid parameters' do
        let(:new_attributes) { { content: 'New content' } }

        it 'updates the requested data crumb' do
          put "/data_crumbs/#{data_crumb.id}", params: { data_crumb: new_attributes }
          data_crumb.reload
          expect(data_crumb.content).to eq('New content')
        end
      end

      context 'with invalid parameters' do
        let(:action) do
          put "/data_crumbs/#{data_crumb.id}", params: { data_crumb: invalid_attributes }
        end

        it 'does not update the data crumb' do
          action
          data_crumb.reload
          expect(data_crumb.content).to eq('Valid content')
        end

        it "renders the 'edit' template" do
          action
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE /data_crumbs/:id' do
      let!(:data_crumb) { create(:data_crumb, warehouse:) }
      let(:action) { delete "/data_crumbs/#{data_crumb.id}" }

      it 'destroys the requested data crumb' do
        expect { action }.to change(DataCrumb, :count).by(-1)
      end
    end

    describe 'GET /data_crumbs' do
      let(:action) { get '/data_crumbs' }

      before { create_list(:data_crumb, 3, warehouse:) }

      it 'renders the index template' do
        action
        expect(response).to render_template(:index)
      end

      it 'assigns @data_crumbs' do
        action
        expect(assigns(:data_crumbs).ids).to eq(DataCrumb.where(warehouse_id: authenticated_user.warehouses.ids).order(created_at: :desc).ids)
      end
    end
  end

  describe 'unauthorized' do
    describe 'POST /data_crumbs' do
      let(:action) { post '/data_crumbs' }

      it_behaves_like 'unauthorized request'
    end

    describe 'PUT /data_crumbs/:id' do
      let(:action) { put '/data_crumbs/1' }

      it_behaves_like 'unauthorized request'
    end

    describe 'DELETE /data_crumbs/:id' do
      let(:action) { delete '/data_crumbs/1', params: { id: 1 } }

      it_behaves_like 'unauthorized request'
    end

    describe 'GET /data_crumbs' do
      let(:action) { get '/data_crumbs' }

      it_behaves_like 'unauthorized request'
    end
  end
end
