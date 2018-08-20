# frozen_string_literal: true

module Api
  module V1
    describe CommentsController, type: :request do
      let!(:user) { create(:user) }
      let!(:headers) { user.create_new_auth_token }
      let!(:project) { create(:project, user: user) }
      let!(:task) { create(:task, project: project) }
      let!(:comment) { create(:comment, task: task) }
      let!(:comment_params) { attributes_for(:comment, task: task) }

      context 'GET #index' do
        it 'return status code 200' do
          get api_v1_project_task_comments_path(project, task), headers: headers
          expect(response).to have_http_status(200)
          expect(json).not_to be_empty
          expect(response).to match_json_schema('comments')
        end
      end

      context 'POST #create' do
        it 'create task successfully' do
          expect do
            post api_v1_project_task_comments_path(project, task),
                 headers: headers, params: comment_params
          end.to change(Comment, :count).by(1)
          expect(response).to have_http_status(201)
          expect(response).to match_json_schema('comment')
        end
      end

      context 'DELETE #destroy' do
        it 'delete comment' do
          expect do
            delete api_v1_project_task_comment_path(project, task, comment),
                   headers: headers
          end.to change(Comment, :count).by(-1)
        end
      end
    end
  end
end
