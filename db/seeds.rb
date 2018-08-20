# frozen_string_literal: true

Project.destroy_all
Task.destroy_all
Comment.destroy_all

5.times do
  project = Project.create(title: FFaker::Movie.title)
  3.times do |index|
    task = Task.create(title: FFaker::Movie.title,
                       index: index, project: project)
    Comment.create(content: FFaker::Movie.title, task: task)
  end
end
