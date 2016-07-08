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
  end


end
