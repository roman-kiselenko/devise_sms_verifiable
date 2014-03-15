class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  def new
    super
  end

  def create
    super
  end

  def update
    super
  end
end
