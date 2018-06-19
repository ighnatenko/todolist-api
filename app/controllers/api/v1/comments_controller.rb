module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource :task
      load_and_authorize_resource through: :task, only: %i[index create]
      load_and_authorize_resource only: :destroy
  
      def index
        render json: @comments, each_serializer: Api::CommentSerializer, status: :ok
      end
  
      def create
        if @comment.save
          render json: @comment, serializer: Api::CommentSerializer, status: :created
        else
          render json: {errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      def destroy
        @comment.destroy
        render status: :ok
      end
  
      private
  
      def comment_params
        params.permit(:content, :file)
      end
    end
  end
end