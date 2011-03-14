class PhysiciansController < ApplicationController
    respond_to :html

    def index
      @physicians = Physician.all
    end

    def show
      @physician = Physician.find(params[:id])
    end

    def new
      @physician = Physician.new
    end

    def create
      @physician = Physician.new(params[:physician])

      if @physician.save
        redirect_to @physician, :notice => "Successfully created Physician."
      else
        render :action => 'new'
      end
    end

    def edit
      @physician = Physician.find(params[:id])
    end

    def update
      @physician = Physician.find(params[:id])
      if @physician.update_attributes(params[:physician])
        redirect_to @physician, :notice  => "Successfully updated Physician."
      else
        render :action => 'edit'
      end
    end

    def destroy
      @physician = Physician.find(params[:id])
      @physician.destroy
      redirect_to physicians_url, :notice => "Successfully removed Physician."
    end
  end


