class MealsController < ApplicationController
  before_filter :current_user
  def meal_params
    params.require(:meal).permit(:meal_name, :meal_calories, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :VGN, :VGT, :GF, :NF,:DF, :description)
  end

  def new
    # used by ADMIN to generate new meal options
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
  end

  def create
    # used by ADMIN to generate new meal options
    diet_hash = Hash.new
    if meal_params[:VGN]
      diet_hash[:VGN] = true
    else
      diet_hash[:VGN] = false
    end
    if meal_params[:VGT]
      diet_hash[:VGT] = true
    else
      diet_hash[:VGT] = false
    end
    if meal_params[:GF]
      diet_hash[:GF] = true
    else
      diet_hash[:GF] = false
    end
    if meal_params[:NF]
      diet_hash[:NF]= true
    else
      diet_hash[:NF]= false
    end
    if meal_params[:DF]
      diet_hash[:DF] = true
    else
      diet_hash[:DF] = false
    end
    diet_hash = diet_hash.to_s
    @meal = Meal.new({:meal_name => meal_params[:meal_name], :meal_calories => meal_params[:meal_calories], :monday => meal_params[:monday], :tuesday=> meal_params[:tuesday], :wednesday=> meal_params[:wednesday], :thursday => meal_params[:thursday], :friday => meal_params[:friday], :saturday => meal_params[:saturday], :sunday => meal_params[:sunday], :dietary_restrictions => diet_hash, :description => meal_params[:description]})
    begin
    @meal.save!
    rescue Exception => e
      flash[:warning] = "Invalid meal. All fields must be filled out and the name must be unique."
      redirect_to new_meal_path

  else
    flash[:notice] = "#{@meal.meal_name} was successfully created."
    redirect_to meals_path
  end

  end

  def show
    # used by STUDENT to show the details of a specific meal options
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    @meal = Meal.find(params[:id])
    respond_to do |format|
      format.html { render :partial => 'meal' and return if request.xhr? }
      format.xml { render :xml => @meal and return }
      format.json {render :json => @meal and return}
    end
  end

  def index
    # used by ADMIN to list all possible meal options
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    sort = params[:sort] || session[:sort]
    case sort
    when 'name'
      ordering, @name_header = {:meal_name => :asc}, 'hilite'
    when 'calories'
      ordering, @calorie_header = {:meal_calories => :asc}, 'hilite'
    when 'monday'
      ordering, @monday_header = {:monday => :desc}, 'hilite'
    when 'tuesday'
      ordering, @tuesday_header = {:tuesday => :desc}, 'hilite'
    when 'wednesday'
      ordering, @wednesday_header = {:wednesday => :desc}, 'hilite'
    when 'thursday'
      ordering, @thursday_header = {:thursday => :desc}, 'hilite'
    when 'friday'
      ordering, @friday_header = {:friday => :desc}, 'hilite'
    when 'saturday'
      ordering, @saturday_header = {:saturday => :desc}, 'hilite'
    when 'sunday'
      ordering, @sunday_header = {:sunday => :desc}, 'hilite'

    end

    @all_restrictions = Meal.all_restrictions
    @selected_admin_restrictions = params[:restrictions] || session[:restrictions] || {}

    selected_restrictions_array = []
    @meals = []

    @selected_admin_restrictions.each do |k, v|
      selected_restrictions_array << k
    end

    if selected_restrictions_array.empty?
      @meals = Meal.all.order(ordering)
    else
      Meal.all.order(ordering).each do |meal|
        temp_array = []
        eval(meal.dietary_restrictions).each do |k, v|
          if v == true
            temp_array << k.to_s
          end
        end

        if (selected_restrictions_array - temp_array).empty?
          @meals << meal
        end
      end
    end

    # @meals = Meal.all.order(ordering)
  end

  def edit
    # used by ADMIN to edit a specific meal option
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    @meal = Meal.find(params[:id])
    @restrictions = eval(@meal.dietary_restrictions)
  end

  def update
    # used by ADMIN to edit a specific meal option
    # not currently being used
  end

  def destroy
    # used by ADMIN to delete meal options
    @meal = Meal.find(params[:id])
    @meal.destroy
    flash[:notice] = "Meal '#{@meal.meal_name}' was deleted."
    redirect_to meals_path
  end

  def current_menu
    # used by STUDENT to give an index of meal options, filtered to show only today's menu and by dietary restrictions
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    sort = params[:sort] || session[:sort]
    case sort
    when 'calories'
      ordering, @calories_header = {:meal_calories => :asc}, 'hilite'
    when 'meal_name'
      ordering, @meal_name_header = {:meal_name => :asc}, 'hilite'
    end

    today = Time.new.wday
    weekdays = { 0 => :sunday, 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday}

    @all_restrictions = Meal.all_restrictions
    @selected_restrictions = params[:restrictions] || session[:restrictions] || {}
    @student_restrictions = eval(current_student.dietary_restrictions)

    selected_restrictions_array = []
    @current_meals = []

    if params.has_key?(:account)
      @selected_restrictions.each do |k, v|
        selected_restrictions_array << k
      end
    else
      @student_restrictions.each do |k, v|
        if v
          selected_restrictions_array << Meal.get_restriction_string(k)
          @selected_restrictions[Meal.get_restriction_string(k)] = '1'
        end
      end
    end

    if selected_restrictions_array.empty?
      @current_meals = Meal.where(weekdays[today] => true).order(ordering)
    else
      Meal.where(weekdays[today] => true).order(ordering).each do |meal|
        temp_array = []
        eval(meal.dietary_restrictions).each do |k, v|
          if v == true
            temp_array << k.to_s
          end
        end

        if (selected_restrictions_array - temp_array).empty?
          @current_meals << meal
        end
      end
    end
  end

  def tomorrows_menu
    # used by STUDENT to see a preview of the next day's menu
    unless current_student
      flash[:warning] = 'You do not have permission to view that page. '
      redirect_to root_path
    end
    today = current_day.wday
    tomorrow = (today + 1) % 7 # since saturday is 6 and sunday is 0, this accounts for the switch
    weekdays = { 0 => :sunday, 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday}
    sort = params[:sort] || session[:sort]
    case sort
    when 'calories'
      ordering, @calories_header = {:meal_calories => :asc}, 'hilite'
    when 'name'
      ordering, @name_header = {:meal_name => :asc}, 'hilite'
    end
    @current_meals = Meal.where(weekdays[tomorrow] => true).order(ordering)
  end

  def schedule
    # admin uses to edit meals
    begin
    @meal = Meal.find_by_meal_name(params[:meal][:meal_name])
    diet_hash = Hash.new
    if meal_params[:VGN] == "1"
      diet_hash[:VGN] = true
    else
      diet_hash[:VGN] = false
    end
    if meal_params[:VGT] == "1"
      diet_hash[:VGT] = true
    else
      diet_hash[:VGT] = false
    end
    if meal_params[:GF] == "1"
      diet_hash[:GF] = true
    else
      diet_hash[:GF] = false
    end
    if meal_params[:NF] == "1"
      diet_hash[:NF]= true
    else
      diet_hash[:NF]= false
    end
    if meal_params[:DF] == "1"
      diet_hash[:DF] = true
    else
      diet_hash[:DF] = false
    end
    diet_hash = diet_hash.to_s
    @meal.update_attributes!({:meal_name => meal_params[:meal_name], :meal_calories => meal_params[:meal_calories], :monday => meal_params[:monday], :tuesday=> meal_params[:tuesday], :wednesday=> meal_params[:wednesday], :thursday => meal_params[:thursday], :friday => meal_params[:friday], :saturday => meal_params[:saturday], :sunday => meal_params[:sunday], :dietary_restrictions => diet_hash, :description => meal_params[:description]})
    flash[:notice] = "#{@meal.meal_name} was successfully updated."
    redirect_to meals_path
    rescue Exception => e
      flash[:warning] = 'An error occurred updating the meal, make sure all attributes are filled out'
      redirect_to meals_path
      end
  end
end
