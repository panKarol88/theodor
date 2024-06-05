require 'rails_helper'

RSpec.describe DataCrumbsController, type: :controller do
  let(:valid_attributes) { { content: 'Valid content' } }
  let(:invalid_attributes) { { content: '' } }
  let(:valid_session) { {} }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new DataCrumb" do
        expect {
          post :create, params: { data_crumb: valid_attributes }, session: valid_session
        }.to change(DataCrumb, :count).by(1)
      end

      it "redirects to the data crumbs list" do
        post :create, params: { data_crumb: valid_attributes }, session: valid_session
        expect(response).to redirect_to(data_crumbs_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new DataCrumb" do
        expect {
          post :create, params: { data_crumb: invalid_attributes }, session: valid_session
        }.to change(DataCrumb, :count).by(0)
      end

      it "renders the 'new' template" do
        post :create, params: { data_crumb: invalid_attributes }, session: valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT /update" do
    let(:data_crumb) { DataCrumb.create! valid_attributes }

    context "with valid parameters" do
      let(:new_attributes) { { content: 'New content' } }

      it "updates the requested data crumb" do
        put :update, params: { id: data_crumb.to_param, data_crumb: new_attributes }, session: valid_session
        data_crumb.reload
        expect(data_crumb.content).to eq('New content')
      end

      it "redirects to the data crumbs list" do
        put :update, params: { id: data_crumb.to_param, data_crumb: valid_attributes }, session: valid_session
        expect(response).to redirect_to(data_crumbs_path)
      end
    end

    context "with invalid parameters" do
      it "does not update the data crumb" do
        put :update, params: { id: data_crumb.to_param, data_crumb: invalid_attributes }, session: valid_session
        data_crumb.reload
        expect(data_crumb.content).to eq('Valid content')
      end

      it "renders the 'edit' template" do
        put :update, params: { id: data_crumb.to_param, data_crumb: invalid_attributes }, session: valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:data_crumb) { DataCrumb.create! valid_attributes }

    it "destroys the requested data crumb" do
      expect {
        delete :destroy, params: { id: data_crumb.to_param }, session: valid_session
      }.to change(DataCrumb, :count).by(-1)
    end

    it "redirects to the data crumbs list" do
      delete :destroy, params: { id: data_crumb.to_param }, session: valid_session
      expect(response).to redirect_to(data_crumbs_path)
    end
  end

  describe "GET /index" do
    before { create_list(:data_crumb, 3) }

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @data_crumbs" do
      get :index
      expect(assigns(:data_crumbs)).to eq(DataCrumb.all)
    end
  end
end
