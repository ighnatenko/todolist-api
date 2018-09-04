# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      load_and_authorize_resource :project, through: :current_api_user
      load_and_authorize_resource :task, through: :project
      load_and_authorize_resource through: :task,
                                  only: %i[index create destroy]

      api :GET, '/projects/:id/tasks/:id/comments', 'Show all comments'
      def index
        render json: @comments, each_serializer: Api::CommentSerializer,
               status: :ok
      end

      api :POST, '/projects/:id/tasks/:id/comments', 'Create a comment'
      param :resource_param, Hash, desc: 'Param description for all methods' do
        param :content, String, required: true
        param :file, File
      end
      def create
        if @comment.save
          render json: @comment, serializer: Api::CommentSerializer,
                 status: :created
        else
          render json: { errors: @comment.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      api :DELETE, '/projects/:id/tasks/:id/comments/:id', 'Delete a comment'
      param :id, :number, required: true
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
