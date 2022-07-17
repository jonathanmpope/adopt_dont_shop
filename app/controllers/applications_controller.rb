class ApplicationsController < ApplicationController

    def new 
    end

    def create
        application = Application.new(application_params)
        if application.save
            flash.clear
            redirect_to "/applications/#{application.id}"
        else
            flash[:notice] = "*Fields can not be empty*"
            render :new
        end
    end

    def show
        @application = Application.find(params[:application_id])
        if params[:search] != nil 
            @pets = Pet.find_by_name(params[:search])
        else     
            @pets = []
        end 
    end

    def apppetscreate
        application = Application.find(params[:application_id])
        pet = Pet.find(params[:pet_id])
        PetApplication.create(pet: pet, application: application)
        redirect_to "/applications/#{application.id}"
    end 

    def update
        application = Application.find(params[:application_id])
        application.update(description: params[:description], status:"Pending")
        redirect_to "/applications/#{application.id}"
    end 

    private
    def application_params
        params.permit(:name, :street, :city, :state, :zipcode, :description, :status)
    end 

end  