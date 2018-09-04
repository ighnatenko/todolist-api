# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      load_and_authorize_resource through: :current_api_user,
                                  only: %i[index create update destroy]

      api :GET, '/projects', 'Show all projects'
      def index
        @projects = @projects.order('created_at')
        render json: @projects, each_serializer: Api::ProjectSerializer
      end

      api :POST, '/projects', 'Create a project'
      param :title, String, required: true
      def create
        if @project.save
          render json: @project, serializer: Api::ProjectSerializer
        else
          render status: :unprocessable_entity
        end
      end

      api :DELETE, '/projects/:id', 'Delete a project'
      param :id, :number, required: true
      def destroy
        @project.destroy
        render status: :ok
      end

      api :PUT, '/projects/:id', 'Update a project'
      param :resource_param, Hash, desc: 'Param description for all methods' do
        param :id, :number, desc: 'ID for project', required: true
        param :title, String, desc: 'Title for project', required: true
      end
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
