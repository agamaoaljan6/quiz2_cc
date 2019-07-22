class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        idea = Idea.find params[:idea_id]
        like = Like.new(user: current_user, idea: idea)
        if not can?(:like, idea)
            flash[:danger] = "For real?"
            return redirect_to idea_path(idea)
        end

        if like.save
            flash[:success] = "Idea liked!"
            redirect_to idea_path(idea)
        end
    end
    def destroy
        idea = Idea.find params[:idea_id]
        like = Like.find params[:id]

        if like.destroy
        flash[:danger] = "unliked"
        redirect_to idea_path(idea)
        end
    end
end
