class SearchService
  def initialize(data, ip)
    @query = data[:search].gsub(/[^0-9A-Za-z ]/, '')
    @activity = data[:activity]
    @user_id = ip
    @activity_id = data[:activity].first
    @query_form_activity = Query.find_by(act_identifier: @activity.first)
    @increment_query = Query.find_by(user_id: @user_id, query: @query)
    @simular_queries = Query.search(@query).user(@user_id)
    @errors = []
  end

  def filter
    @results = Article.search(@query).limit(6)
    @increment_query.nil? ? create_new_query : increment_query
    
    remove_subqueries if @increment_query.nil? && part_of_session?
    decrement_query_counter if !part_of_session? && !@query_form_activity.nil?
    
    @simular_queries.each{|query| query.delete if included_and_shorter(query.query)}
    return_results
  end

  private

  def included_and_shorter(query)
    @query.include?(query) && query.length < @query.length if !@simular_queries.blank?
  end

  def return_results
    return @results.blank? ? 
    {error_message: ["We ware not able to find results for search '#{@query}'"], error_code: 404} 
    : {data: {data: @results, errors: @errors}}

  end

  def part_of_session?
    if !@query_form_activity.nil?
      @query_form_activity.counter == 1
    end
  end

  def decrement_query_counter
    @query_form_activity.update(counter: @query_form_activity.counter - 1, act_identifier: 0)
  end

  def new_query?
    !@query_form_activity.nil? && @query.include?(@query_form_activity.query)
  end

  def create_new_query
    @new_query = Query.create!(user_id: @user_id, act_identifier: @activity_id, found: !@results.blank?, query: @query)
  end

  def increment_query
    @increment_query.update(act_identifier: @activity_id, counter: @increment_query.counter+1)
  end

  def remove_subqueries
    @query_form_activity.delete
  end
end