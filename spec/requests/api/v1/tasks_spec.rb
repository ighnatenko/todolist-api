# frozen_string_literal: true

module Api
  module V1
    describe TasksController, type: :request do
      let!(:user) { create(:user) }
      let!(:headers) { user.create_new_auth_token }
      let!(:project) { create(:project, user: user) }
      let!(:task) { create(:task, project: project) }
      let!(:task_params) { attributes_for(:task, project: project) }

      context 'GET #index' do
        it 'get all task', :show_in_doc do
          get api_v1_project_tasks_path(project), headers: headers
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
          expect(response).to match_json_schema('tasks')
        end
      end

      context 'POST #create' do
        it 'return status code 201' do
          post api_v1_project_tasks_path(project),
               headers: headers, params: task_params
          expect(response).to have_http_status(201)
        end

        it 'create task' do
          expect do
            post api_v1_project_tasks_path(project),
                 headers: headers, params: task_params
          end.to change(Task, :count).by(1)
        end

        it 'returns Task', :show_in_doc do
          post api_v1_project_tasks_path(project),
               headers: headers, params: task_params
          expect(response.status).to eq 201
          expect(response).to match_json_schema('task')
        end
      end

      context 'PUT #update' do
        it 'update task content' do
          put api_v1_project_task_path(project, task),
              headers: headers, params: task_params
          expect(response).to have_http_status(200)
          expect(Task.last.title).to eq(task_params[:title])
        end

        it 'returns Task', :show_in_doc do
          put api_v1_project_task_path(project, task),
              headers: headers, params: task_params
          expect(response).to have_http_status(200)
          expect(response).to match_json_schema('task')
        end
      end

      context 'DELETE #destroy' do
        it 'delete task' do
          expect do
            delete api_v1_project_task_path(project, task),
                   headers: headers
          end.to change(Task, :count).by(-1)
        end
      end

      context 'POST #sorting' do
        let(:first_task) do
          create(:task, project: project, index: 1)
        end

        let(:second_task) do
          create(:task, project: project, index: 1)
        end

        it 'sorting tasks successfully' do
          patch api_v1_project_sort_path(project), headers: headers, params: {
            tasks: [
              { id: first_task.id, index: second_task.index },
              { id: second_task.id, index: first_task.index }
            ]
          }

          expect(Task.find_by(id: first_task.id).index).to eq(second_task.index)
          expect(Task.find_by(id: second_task.id).index).to eq(first_task.index)
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
