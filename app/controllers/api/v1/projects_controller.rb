module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_api_user!
      
      def index
        @projects = Project.order('created_at DESC');
        render json: @projects, each_serializer: Api::ProjectSerializer
      end

      def show
        project = Project.find(params[:id])
        render json: project, serializer: Api::ProjectSerializer
      end

      def create
        project = Project.new(project_params)

        if project.save
          render json: project, serializer: Api::ProjectSerializer
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        project = Project.find(params[:id])
        project.destroy
        render status: :ok
      end

      def update
        project = Project.find(params[:id])

        if project.update_attributes(project_params)
          render json: project, serializer: Api::ProjectSerializer
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