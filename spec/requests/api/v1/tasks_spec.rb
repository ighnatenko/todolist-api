module Api
  module V1
    describe TasksController, type: :request do
      let!(:user) { create(:user) }
      let!(:headers) { user.create_new_auth_token }
      let!(:project) { create(:project, user: user) }
      let!(:task) { create(:task, project: project) }
      let!(:task_params) { attributes_for(:task, project: project) }

      context 'GET #index' do
        it 'get all task' do
          get api_v1_project_tasks_path(project), headers: headers
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
        end
      end

      context 'POST #create' do
        it 'return status code 201' do
          post api_v1_project_tasks_path(project), headers: headers, params: task_params
          expect(response).to have_http_status(201)
        end
  
        it 'create task' do
          expect { post api_v1_project_tasks_path(project), headers: headers, params: task_params }.to change(Task, :count).by(1)
        end
      end

      context 'GET #show' do
        it 'returns status code 200' do
          task = create(:task, project: project)
          get api_v1_project_task_path(project, task), headers: headers
          expect(response).to have_http_status(200)
        end
      end

      context 'PUT #update' do
        it 'update task content' do
          task = create(:task, project: project)
          put api_v1_project_task_path(project, task), headers: headers, params: task_params
          expect(response).to have_http_status(200)
          expect(Task.last.title).to eq(task_params[:title])
        end
      end

      context 'DELETE #destroy' do
        it 'delete task' do
          task = create(:task, project: project)
          expect{ delete api_v1_project_task_path(project, task), headers: headers }.to change(Task, :count).by(-1)
        end
      end

      context 'POST #sorting' do
        it 'sorting tasks successfully' do
          first_task = create(:task, project: project, index: 1)
          second_task = create(:task, project: project, index: 2)

          post api_v1_project_sorting_path(project), headers: headers, params: {
            tasks: [
              { id: first_task.id, index: second_task.index },
              { id: second_task.id, index: first_task.index }
            ]
          }

          expect(response).to have_http_status(200)
          expect(Task.find_by(id: first_task.id).index).to eq(second_task.index)
          expect(Task.find_by(id: second_task.id).index).to eq(first_task.index)
        end
      end
    end
  end
end