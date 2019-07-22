require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    def current_user
        @current_user ||= FactoryBot.create :user
    end

    describe "#new" do
        context "without user signed in" do
            it "redirects the user to the login page" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end

            it "sets a danger flash message" do
                get :new
                expect(flash[:danger]).to be
            end
        end

        context "with user signed in" do
            before do
              session[:user_id] = current_user.id
            end

            it "renders a new template" do
                get :new
                expect(response).to(render_template(:new))
            end

            it "sets an instance variable for a new idea" do
                get :new
                expect(assigns(:idea)).to(be_a_new(Idea))
            end
        end
    end

    describe "#create" do

        def valid_request
            post(:create, params: { idea: FactoryBot.attributes_for(:idea) })
        end

        context "without user signed in" do
            it "redirects to the new_session_path" do
              valid_request
              expect(response).to redirect_to(new_session_path)
            end
        end

        context "with user signed in" do

            before do
              session[:user_id] = current_user.id
            end
   
            context "with valid parameters" do
              it "creates a new idea" do
                count_before = Idea.count
                valid_request
                count_after = Idea.count
                expect(count_after).to eq(count_before + 1)
              end
      
              it "redirects to the show page of the new idea" do
                valid_request
                expect(response).to(redirect_to(idea_path(Idea.last.id)))
              end
            end

            context "with invalid parameters" do
                def invalid_request
                  post(
                    :create,
                    params: {
                      idea: FactoryBot.attributes_for(:idea, title: nil)
                    }
                  )
                end
                it "doesn't create a job post" do
                  count_before = Idea.count
                  invalid_request
                  count_after = Idea.count
        
                  expect(count_after).to(eq(count_before))
                end
        
                it "renders the new template" do
                  invalid_request
                  expect(response).to(render_template(:new))
                end
              end
        end
    end

    describe "#show" do
        it "assigns idea to @idea" do
            idea = FactoryBot.create(:idea)
            get :show, params: {id: idea.id }
            expect(assigns(:idea)).to eq(idea)
        end
        it "renders show view" do
            idea = FactoryBot.create(:idea)
            get :show, params: {id: idea.id}
            expect(response).to render_template :show  
        end
    end

end
