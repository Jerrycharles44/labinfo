class WorkshopsController < ApplicationController
    
# View all courses
get '/workshops' do
    if logged_in?
        @workshops = Workshop.all
        erb :"/workshops/index"
    else
        flash[:error] = "You are not currently logged in!"
        redirect to :"/login"
    end
end

# Instructor can view form to create a new course
get '/workshops/new' do
    if logged_in?
        if current_user.workshop_leader
            erb :"/workshops/new"
        else
            flash[:error] = "You are not an instructor!"
            redirect to "/workshops"
        end
    else
        redirect to :"/login"
    end
end

# Instructor CREATE a new course
post '/workshops' do
    @new_workshop = Workshop.create(name: params[:name], icon: params[:icon], description: params[:description], level: params[:level].to_i-1, workshop_leader_id: session[:user_id])

    if @new_workshop.save 
        flash[:message] = "Workshop created"
        redirect to "/teaching"
    else
        flash[:error] = "Please ensure you have filled in all required fields correctly!"
        redirect to "/workshops/new"
    end
end

# All users can view a single course page
get '/workshops/:id' do
    @workshop = find_workshpp(params[:id])
    @workshop_enrollment = UserWorkshop.where(workshop_id: params[:id])
    @existing_registration = nil

    if logged_in?
        if !current_user.workshop_leader
        @existing_registration = UserWorkshop.where("workshop_id = ? AND user_id = ?", params[:id], current_user.id).first
        end

        erb :"/workshops/show"
    else
        flash[:error] = "You are not currently logged in!"
        redirect to "/login"
    end
end

# Instructor can update student enrollment status
post '/workshops/:id/enrollment' do
    @workshop = find_workshop(params[:id])
    if current_user.workshop_leader && current_user.id === @workshop.workshop_leader.id
        @student_enrollment = UserWorkshop.find_by_id(params[:confirmation][0].to_i)
        @student_enrollment.update(confirmation: params[:confirmation][2].to_i)

        flash[:message] = "Student registrations updated!"
        redirect to "/workshops/#{@workshop.id}"
    else
        redirect to "/workshops/#{@workshop.id}"
    end
end

# Instructor can EDIT a course information
get '/courses/:id/edit' do
    @workshop = find_workshop(params[:id])
    if logged_in?
        if current_user.workshop_leader && current_user.id === @workshop.workshop_leader_id
            erb :"/workshops/edit_workshop"
        elsif current_user.workshop_leader && current_user.id != @workshop.workshop_leader_id
            flash[:error] = "You are not the instructor for this workshop!"
            redirect to "/workshops/#{@workshop.id}"
        else !current_user.workshop_leader
            flash[:error] = "You are not an workshop leader!"
            redirect to :"/login"
        end
    end
end

# Instructor can UPDATE course based on form input
patch '/workshops/:id' do
    @workshop = find_workshop(params[:id])
    @workshop.update(name: params[:name], icon: params[:icon], description: params[:description], level: params[:level].to_i-1)

    if current_user.workshop_leader && current_user.id === @workshop.workshop_leader_id
        if @course.save
            flash[:message] = "Successfully edited course."
            redirect to "/workshops/#{@workshop.id}"
        else 
            flash[:message] = "Something went wrong. Please try to edit course again."
            redirect to "/workshops/#{@workshop.id}/edit"
        end
    else
        redirect to "/workshops/#{@workshop.id}"
    end
end

# Instructor can DELETE their own courses
delete '/courses/:id' do
    @workshop = find_workshop(params[:id])
    if current_user.id === @workshop.workshop_leader_id
        @workshop.destroy
        flash[:deleted] = "Workshop deleted"
        redirect to "/teaching"
    else
        redirect to "/workshops"
    end
end

# Student can UPDATE course registration
post '/workshops/:id/registration' do
    @workshop = find_course(params[:id])
    @new_enrollment = UserWorkshop.create(notes: params[:notes], user_id: current_user.id, workshop_id: params[:id])
    
    if @new_enrollment.save
        flash[:message] = "Successfully registered for this course."
        redirect to "/workshops/#{@workshop.id}"
    else 
        flash[:error] = "Something went wrong. 
        Please try to register for this course again, remember to include a Request Note to your instructor!"
        redirect to "/workshops/#{@workshop.id}"
    end
end

end