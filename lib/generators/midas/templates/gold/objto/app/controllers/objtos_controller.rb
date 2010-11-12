class <%= obj_after_to.camelize.pluralize %>Controller < ApplicationController
  def index
    @<%= obj_after_to.pluralize %> = <%= obj_after_to.camelize %>.all
  end
  
  def show
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.find(params[:id])
  end
  
  def new
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.new
  end
  
  def create
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.new(params[:<%= obj_after_to %>])
    if @<%= obj_after_to %>.save
      flash[:notice] = "Successfully created <%= obj_after_to %>."
      redirect_to @<%= obj_after_to %>
    else
      render :action => 'new'
    end
  end
  
  def edit
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.find(params[:id])
  end
  
  def update
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.find(params[:id])
    if @<%= obj_after_to %>.update_attributes(params[:<%= obj_after_to %>])
      flash[:notice] = "Successfully updated <%= obj_after_to %>."
      redirect_to @<%= obj_after_to %>
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @<%= obj_after_to %> = <%= obj_after_to.camelize %>.find(params[:id])
    @<%= obj_after_to %>.destroy
    flash[:notice] = "Successfully destroyed <%= obj_after_to %>."
    redirect_to <%= obj_after_to.pluralize %>_url
  end
end
