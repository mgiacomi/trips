class ParentsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @parent = Parent.find_or_initialize_by(user_id: current_user.id)
  end

  def update
    @parent = Parent.find_or_initialize_by(user_id: current_user.id)

    if @parent.update(parent_params)
      redirect_to todos_home_path, notice: 'Parent fields successfully updated.'
    else
      render 'edit'
    end
  end

  def parent_params
    params.require(:parent).permit(:p1fname, :p1lname, :p1phone, :p1email, :p1street, :p1city, :p1state, :p1zip, :p2fname, :p2lname, :p2phone, :p2email, :p2street, :p2city, :p2state, :p2zip)
  end
end
