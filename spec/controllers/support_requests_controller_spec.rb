require 'rails_helper'

RSpec.describe SupportRequestsController, type: :controller do

    let(:support_request) { FactoryGirl.create(:support_request) }

    describe "#new" do

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates a new Support Request object and set it to @support_request" do
        get :new
        expect(assigns(:support_request)).to be_a_new(SupportRequest)
      end
    end

    describe "#create" do
      context "with valid attributes" do

        def valid_request
          post :create, support_request: { name: "addbc", email: "eldedefizibin@gmail.com", message: "efasasda da da ds sdasdg", department: "Marketing" }
        end

        it "creates a record in the database" do
          db_count_before = SupportRequest.count
          valid_request
          db_count_after = SupportRequest.count
          expect(db_count_after - db_count_before).to eq(1)
        end

        it "redirects to the campaign #show page" do
          valid_request
          expect(response).to redirect_to(support_request_path(SupportRequest.last))
        end

        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do

        def invalid_request
          post :create, support_request: { name: "" }
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "doesn't a record in the database" do
          db_count_before = SupportRequest.count
          invalid_request
          db_count_after = SupportRequest.count
          expect(db_count_after).to eq(db_count_before)
        end

        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end

      end
    end

    describe "#show" do
      before do
          get :show, id: support_request
      end

      it "renders the new template" do
        expect(response).to render_template(:show)
      end

      it "finds the object and assigns it to an instance variable" do
        expect(assigns(:support_request)).to eq(support_request)
      end

      it "raises an ActiveRecord error if the ID doesn't exist" do
        expect { get :show, id: 123123123 }.to raise_error(ActiveRecord::RecordNotFound)
      end

    end

    describe "#edit" do
      before do
        get :edit, id: support_request.id
      end

      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end

      it "assigns an instance variable to the associated ID" do
        expect(assigns(:support_request)).to eq(support_request)
      end
    end

    describe "#update" do
      context "with valid attributes" do

        before do
          patch :update, id: support_request, support_request: { name: "abcdefghidjk" }
        end

        it "redirects to show upon successful update" do
          expect(response).to redirect_to(support_requests_path)
        end

        it "updates the record with the new parameters" do
          expect(support_request.reload.name).to eq(support_request.name)
        end

        it "sets a flash message" do
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        before do
          patch :update, id: support_request, support_request: { name: "" }
        end

          it "renders the edit template after bad input" do
            expect(response).to render_template(:edit)
          end

          it "does not save the record to the database" do
            expect(support_request.reload.name).to eq(support_request.name)
          end

          it "displays a flash message for bad input" do
            expect(flash[:alert]).to be
          end
      end
    end

    describe "#destroy" do
      let!(:support_request){FactoryGirl.create(:support_request)}

        def delete_request
          delete :destroy, id: support_request
        end

        it "removes the record from the database" do
          expect{delete :destroy, id: support_request}.to change{SupportRequest.count}.by(-1)
        end

        it "redirects to the index template" do
          delete :destroy, id: support_request
          expect(response).to redirect_to(root_path)
        end

        it "sets a flash message upon deletion" do
          delete :destroy, id: support_request
          expect(flash[:alert]).to be
        end
      end
end
