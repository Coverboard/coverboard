class ProjectsController < ApplicationController
  def new
    @project = Project.new
    render layout: 'landing_page'
  end

  def create
    @project = Project.new allowed_params
    if @project.save
      redirect_to "#{dashboard_path}?project=#{@project.uid}" and return
    end

    render :new, layout: 'landing_page'
  end

  private
    def allowed_params
      params.require(:project).permit(:name)
    end
end
