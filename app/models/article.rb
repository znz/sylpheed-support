class Article < ApplicationRecord
  acts_as_nested_set counter_cache: :children_count

  THRESHOLD_HOURS = 24
end
