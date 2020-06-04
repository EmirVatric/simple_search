class SearchService
  def initialize(data)
    @query = data[:search]
    @activity = data[:activity]
    @user_id = data[:user_id]
    @found = true
    @activity_id = data[:activity].first
    @old_query = Query.find_by(act_identifier: @activity.first)
    @increment_query = Query.find_by(user_id: @user_id, query: @query)
    @errors = []
  end

  def filter
    @increment_query.nil? ? create_new_query : increment_query
    
    remove_subqueries if new_query? && part_of_session?
    decrement_query_counter if new_query? && !part_of_session? && !@old_query.nil?
    
    load_results
  end

  private

  def load_results
    results = Article.search(@query).limit(6)
    @errors << "We ware not able to find results for search '#{@query}'" if results.empty?

    return {data: {data: results, errors: @errors}}
  end

  def part_of_session?
    if !@old_query.nil?
      @old_query.counter == 1
    end
  end

  def new_query?
    @increment_query.nil?
  end

  def decrement_query_counter
    @old_query.update(counter: @old_query.counter - 1, act_identifier: 0)
  end

  def new_query?
    !@old_query.nil? && @query.include?(@old_query.query)
  end

  def create_new_query
    Query.create!(user_id: @user_id, act_identifier: @activity_id, found: @found, query: @query)
  end

  def increment_query
    @increment_query.update(act_identifier: @activity_id, counter: @increment_query.counter+1)
  end

  def remove_subqueries
    @old_query.delete
  end
end