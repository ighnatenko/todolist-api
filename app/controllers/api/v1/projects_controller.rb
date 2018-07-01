module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource through: :current_api_user

      api :GET, '/projects', 'Show all projects'
      meta  data: [{id: 120, title: 'Example title', tasks: []}]
      def index
        @projects = @projects.order('created_at');
        render json: @projects, each_serializer: Api::ProjectSerializer
      end

      api :GET, '/projects/:id', 'Show a project'
      param :id, Fixnum, required: true
      meta  data: {id: 120, title: 'Example title', tasks: []}
      def show
        render json: @project, serializer: Api::ProjectSerializer
      end

      api :POST, '/projects', 'Create a project'
      param :title, String, required: true
      meta  data: {id: 120, title: 'Example title', tasks: []}
      def create
        if @project.save
          render json: @project, serializer: Api::ProjectSerializer
        else
          render status: :unprocessable_entity
        end
      end

      api :DELETE, '/projects/:id', 'Delete a project'
      meta  data: ''
      param :id, Fixnum, required: true
      def destroy
        @project.destroy
        render status: :ok
      end

      api :PUT, '/projects/:id', 'Update a project'
      param :resource_param, Hash, :desc => 'Param description for all methods' do
        param :id, Fixnum, :desc => "ID for project", :required => true
        param :title, String, :desc => "Title for project", :required => true
      end
      meta  data: {id: 120, title: 'Example title', tasks: []}
      def update
        if @project.update_attributes(project_params)
          render json: @project, serializer: Api::ProjectSerializer
        else
          render status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.permit(:title)
      end
    end
  end
end