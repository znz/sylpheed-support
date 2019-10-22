require 'awesome_nested_set/version'
unless %w[3.1.4 3.2.0].include?(AwesomeNestedSet::VERSION)
  raise "AwesomeNestedSet::VERSION changed to #{AwesomeNestedSet::VERSION}"
end
require 'awesome_nested_set/move'
class CollectiveIdea::Acts::NestedSet::Move
  private

  def conditions(a, b, c, d)
    _conditions = case_condition_for_direction(:quoted_left_column_name) +
                  case_condition_for_direction(:quoted_right_column_name) +
                  case_condition_for_parent

    # https://github.com/collectiveidea/awesome_nested_set/issues/389
    ## We want the record to be 'touched' if it timestamps.
    #if @instance.respond_to?(:updated_at)
    #  _conditions << ", updated_at = :timestamp"
    #end

    [
      _conditions,
      {
        :a => a, :b => b, :c => c, :d => d,
        :primary_id => instance.primary_id,
        :new_parent_id => new_parent_id,
        :timestamp => Time.now.utc
      }
    ]
  end
end
