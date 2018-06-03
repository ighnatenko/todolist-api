module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource :project
      load_and_authorize_resource through: :project

      def create
        if @task.save
          render json: @task, each_serializer: Api::TaskSerializer, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      def show
        render json: @task, serializer: Api::TaskSerializer
      end

      def update
        if @task.update(todo_params)
          render json: @task, serializer: Api::TaskSerializer, status: :ok
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        render status: :ok
      end

      def sorting
        Task.transaction do
          params[:tasks].each do |task|
            Task.find_by(id: task[:id]).update!(index: task[:index])
          end
        end
        render status: :ok
      end

      private

      def todo_params
        params.permit(:title, :index, :done, :expiration_date)
      end
    end
  end
end