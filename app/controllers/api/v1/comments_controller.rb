module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource :task
      load_and_authorize_resource through: :task, only: %i[index create]
      load_and_authorize_resource only: :destroy
  
      api :GET, '/projects/:id/tasks/:id/comments', 'Show all comments'
      example  "data: [{id: 120, content: 'title', file: {url: 'http://todox-api...'}, created_date: '01/01/18', task_id: 33}]"
      def index
        render json: @comments, each_serializer: Api::CommentSerializer, status: :ok
      end
  
      api :POST, '/projects/:id/tasks/:id/comments', 'Create a comment'
      param :resource_param, Hash, :desc => 'Param description for all methods' do
        param :content, String, required: true
        param :file, File
      end
      example  "data: [{id: 120, content: 'title', file: {url: 'http://todox-api...'}, created_date: '01/01/18', task_id: 33}]"
      def create
        if @comment.save
          render json: @comment, serializer: Api::CommentSerializer, status: :created
        else
          render json: {errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      api :DELETE, '/projects/:id/tasks/:id/comments/:id', 'Delete a comment'
      param :id, :number, required: true
      example  "data: ''"
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