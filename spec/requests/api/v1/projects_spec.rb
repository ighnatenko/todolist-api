 module Api
  module V1
    describe ProjectsController, type: :request do
      let!(:user) { create(:user) }
      let!(:headers) { user.create_new_auth_token }
      let!(:project_params) { attributes_for(:project) }

      context 'GET /projects' do
        it 'returns projects' do
          create(:project, user: user)
          get api_v1_projects_path, headers: headers
          expect(json.count).to eq(user.projects.count)
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
        end
      end

      context 'POST #create' do
        it 'empty title' do
          post api_v1_projects_path, headers: headers, params: {title: ''}
          expect(response).to have_http_status(422)
        end
  
        it 'create project' do
          expect{post api_v1_projects_path, headers: headers, params: project_params}.to change(Project, :count).by(1)
          expect(json).not_to be_empty
        end
      end

      context 'GET #show' do
        it 'returns status code 200' do
          project = create(:project, user: user)
          get api_v1_project_path(project), headers: headers
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
        end
      end

      context 'PUT #update' do
        it 'changes title' do
          project = create(:project, user: user)
          put api_v1_project_path(project), headers: headers, params: {title: 'title'}
          expect(Project.last.title).to eq('title')
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
        end
      end

      context 'DELETE #destroy' do
        it 'remove project' do
          project = create(:project, user_id: user.id)
          expect{ delete api_v1_project_path(project), headers: headers }.to change(Project, :count).by(-1)
        end
      end
    end
  end
end