require './lib/blog_app/repos/clusters_repo'
require './lib/blog_app/entities/comment'
require './lib/blog_app/entities/follow'

class ActiverecordClustersRepo < BlogApp::Repos::ClustersRepo
  def search(params = {})
    if params[:user_email].present?
      user = User.where(email: params[:user_email]).first
      ids = { post: [], article: []}
      user.follows.includes(:followable).each do |follow|
        ids[follow.followable.commentable_type.underscore.to_sym] << follow.followable.commentable_id
      end unless user.nil?

      params[:_or] = []
      params[:_or] << {_and: [{type: 'post'}, {id: ids[:post].uniq}]} if ids[:post].present?
      params[:_or] << {_and: [{type: 'article'}, {id: ids[:article].uniq}]} if ids[:article].present?
    end

    Searchkick.search "*", where: params.to_h.tap{|hash| hash.delete(:page)}.deep_symbolize_keys, models: [Article, Post], order: {follows_count: :desc}, page: params[:page], per_page: 5

    #result = Searchkick.search "*", where: {follows_count: {gt: 3}}, models: [Article, Post], order: {follows_count: :desc}, page: 1, per_page: 20
    #result = Searchkick.search "*", where: {user_email: 'beal0829', _or: [_and: [{_type: 'post'}, {_id: [1]}], _and: [{_type: 'article'}, {_id: [1]}]  ]}, models: [Article, Post], order: {follows_count: :desc}, page: 1, per_page: 20
  end
end
