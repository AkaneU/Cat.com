class Public::SearchesController < ApplicationController
  
  #検索ワードの画面にて人気のタグを10個表示
  def search
    @tags = Post.tag_counts_on(:tags).most_used(10)
  end

  def search_result
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content).page(params[:page]).per(10)
  end
  
  #全てのタグを表示
  def all_tags
    @tags = Post.tag_counts_on(:tags)
  end

  private

  def search_for(model, content)
    if model == 'end_user'
      EndUser.where("name LIKE ?", "%#{content}%")
    elsif model == 'post'
      Post.where("title LIKE ?", "%#{content}%")
    end
  end

end
