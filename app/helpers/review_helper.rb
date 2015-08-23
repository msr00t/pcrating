# Helper methods for the review pages
module ReviewHelper
  def select_options(review, stat)
    options = STATS[stat][:ranks].keys
    selected_option = review.send(stat)
    options_for_select(options, selected_option)
  end
end
