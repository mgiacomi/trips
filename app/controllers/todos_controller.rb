class TodosController < ApplicationController
  before_filter :authenticate_user!, :except => [:denied, :new]

#  def index
#  def new
#  def create
#  def show
#  def edit
#  def update
#  def destroy

  def status
    @registration = Registration.find_by(user_id: current_user.id)
  end

  def denied
  end


end
