module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_api_user!
      load_and_authorize_resource through: :current_api_user

      def index
        @projects = @projects.order('created_at DESC');
        render json: @projects, each_serializer: Api::ProjectSerializer
      end

      def show
        render json: @project, serializer: Api::ProjectSerializer
      end

      def create
        if @project.save
          render json: @project, serializer: Api::ProjectSerializer
        else
          render status: :unprocessable_entity
        end
      end

      def destroy
        @project.destroy
        render status: :ok
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