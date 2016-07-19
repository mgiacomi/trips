class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  belongs_to :registraion

  def overview

  end

end
