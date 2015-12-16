class DashboardController < ApplicationController
  def index
    @project_name = get_project_name
  end

  private
    def get_project_name
      project = Project.find_by_uid(params[:project])
      return '' if project.nil?

      project.name
    end
end
