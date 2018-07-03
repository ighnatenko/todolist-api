module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource :project
      load_and_authorize_resource through: :project, only: %i[index create]
      load_and_authorize_resource only: %i[show update destroy sorting]

      api :GET, '/projects/:id/tasks', 'Show all tasks'
      example  "data: [{id: 120, title: 'title', comments: [], done: false, expiration_date: '01/01/18', index: 1}]"
      def index
        @tasks = @tasks.order('index');
        render json: @tasks.includes(:project), each_serializer: Api::TaskSerializer
      end

      api :POST, '/projects/:id/tasks', 'Create a task'
      param :resource_param, Hash, :desc => 'Param description for all methods' do
        param :title, String, required: true
        param :index, :number, required: true
        param :done, [true, false]
        param :expiration_date, Date
      end
      example "data: {id: 120, title: 'Example title', comments: [], done: false, expiration_date: '01/01/18', index: 1}"
      def create
        if @task.save
          render json: @task, each_serializer: Api::TaskSerializer, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      api :GET, '/projects/:id/tasks/:id', 'Show a task'
      param :id, :number, required: true
      example "data: {id: 120, title: 'Example title', comments: [], done: false, expiration_date: '01/01/2018', index: 1}"
      def show
        render json: @task, serializer: Api::TaskSerializer
      end

      api :PUT, '/projects/:id/tasks', 'Update a task'
      param :resource_param, Hash, :desc => 'Param description for all methods' do
        param :title, String
        param :index, :number
        param :done, [true, false]
        param :expiration_date, Date
      end
      example "data: {id: 120, title: 'title', comments: [], done: false, expiration_date: '01/01/2018', index: 1}"
      def update
        if @task.update(task_params)
          render json: @task, serializer: Api::TaskSerializer, status: :ok
        else
          render status: :unprocessable_entity
        end
      end

      api :DELETE, '/projects/:id/tasks/:id', 'Delete a task'
      param :id, :number, required: true
      example "data: ''"
      def destroy
        @task.destroy
        render status: :ok
      end

      api :POST, '/projects/:id/tasks/:id', 'Sorting tasks'
      param :resource_param, Array, :desc => 'Two tasks'
      example "data: [{id: 120, title: 'title', comments: [], done: false, expiration_date: '01/01/2018', index: 1},
      {id: 120, title: 'title', comments: [], done: false, expiration_date: '01/01/2018', index: 1}]"
      def sorting
        Task.transaction do
          params[:tasks].each do |task|
            Task.find_by(id: task[:id]).update!(index: task[:index])
          end
        end
        render status: :ok
      end

      private

      def task_params
        params.permit(:title, :index, :done, :expiration_date)
      end
    end
  end
end