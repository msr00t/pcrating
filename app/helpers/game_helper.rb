module GameHelper

  def genre_button_string
    selected_genre || 'Genres'
  end

  def platform_button_string
    selected_platform || 'OS'
  end

  def sort_button_string
    return 'Sort' if selected_sort.blank?
  end

  def category_button_string
    selected_category || 'Features'
  end

  def review_text
    return 'Edit Review' if @game.rated_by_user? current_user
    'Write Review'
  end

  def show_advanced?
    selected_category || selected_sort || selected_genre || selected_platform || ranked_button
  end

  def sort_field_string
    "#{@q.sorts[0].attr_name} #{@q.sorts[0].dir}" unless selected_sort.blank?
  end

  def selected_genre
    search_field_active(:genres_name_cont)
  end

  def selected_platform
    search_field_active(:platforms_name_cont)
  end

  def selected_category
    search_field_active(:categories_name_cont)
  end

  def advanced_button_string
    return 'Hide Advanced Options' if show_advanced?
    'Show Advanced Options'
  end

  def ranked_button
    return false unless params[:q]
    params[:q][:ranked_only] == 'true'
  end

  def search_field_active(param)
    return false unless params[:q]
    field_string = params[:q][param]
    return field_string.titlecase unless field_string.blank?
    false
  end

  def selected_sort
    return params[:q][:s] if params[:q] && !params[:q][:s].blank?
    false
  end

  def get_sort_path(sort)
    if params[:q]
      return games_path(sort_by: sort,
                        "q[title_cont]" => params[:q][:title_cont],
                        "q[genres_name_cont]" => params[:q][:genres_name_cont])
    end

    games_path(genre: params[:genre],
               sort_by: sort)
  end

end