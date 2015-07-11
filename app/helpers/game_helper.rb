module GameHelper

  def genre_button_string
    return selected_genre if selected_genre
    'Genres'
  end

  def sort_button_string
    return 'Sort' if selected_sort.blank?
  end

  def sort_field_string
    "#{@q.sorts[0].attr_name} #{@q.sorts[0].dir}" unless selected_sort.blank?
  end

  def selected_genre
    return false unless params[:q]
    genre_string = params[:q][:genres_name_cont]
    return genre_string.titlecase unless genre_string.blank?
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