class ParentsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @parent = Parent.find_or_initialize_by(user_id: current_user.id)
  end

  def update
    @parent = Parent.find_or_initialize_by(user_id: current_user.id)

    if @parent.update_attributes(params[:parent])
      redirect_to todos_home_path, notice: 'Parent fields successfully updated.'
    else
      render 'edit'
    end
  end
end
