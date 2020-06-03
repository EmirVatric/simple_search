class Filter
  def initialize(data, found)
    @query = data[:search]
    @activity = data[:activity]
    @user_id = data[:user_id]
    @found = found
    @activity_id = data[:activity].first
    @old_query = Query.where(act_identifier: @activity.first)
    @increment_query = Query.where(user_id: @user_id, query: @query)
  end

  def check_query
    remove_subqueries if is_new_itteration && is_part_of_session
    decrement_query_counter if is_new_itteration && !is_part_of_session && @old_query.length == 1

    is_new_query ? create_new_query : increment_query
  end

  private

  def is_part_of_session
    if @old_query.length > 0
      @old_query.first.counter == 1
    end
  end

  def is_new_query
    @increment_query.length == 0
  end

  def decrement_query_counter
    @old_query.first.update(counter: @old_query.first.counter-1, act_identifier: 0)
  end

  def is_new_itteration
    @old_query.length > 0 && @query.include?(@old_query.first.query)
  end

  def create_new_query
    Query.create!(user_id: @user_id, act_identifier: @activity_id, found: @found, query: @query)
  end

  def increment_query
    @increment_query.first.update(act_identifier: @activity_id, counter: @increment_query.first.counter+1)
  end

  def remove_subqueries
    @old_query.each{|q| q.delete}
  end
end