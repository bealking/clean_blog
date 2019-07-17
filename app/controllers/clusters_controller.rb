require './lib/blog_app/use_cases/search_cluster'
require './lib/blog_app/entities/user'

class ClustersController < ApplicationController
  def index
    use_case = BlogApp::UseCases::SearchCluster.new(clusters_repo: ActiverecordClustersRepo.new)
    @result = use_case.execute(search_params)
    objects = @result.map { |object| ClustersSerializer.new(object.domain_object).as_json }
    page_info = {
      previous_page: @result.previous_page,
      total_pages: @result.total_pages,
      current_page: @result.current_page,
      next_page: @result.next_page
    }

    respond_to do |format|
      format.html
      format.json { render json: { objects: objects, page_info: page_info} }
    end
  end

  private

  def search_params
    params.permit(:user_email, :page, follows_count: [:gt])
  end
end
