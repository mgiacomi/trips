class SignupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:denied, :new]

#  def index
#  def new
#  def create
#  def show
#  def edit
#  def update
#  def destroy

  def new
  end

  def show
  end

  def edit
  end

  def denied
  end

end
