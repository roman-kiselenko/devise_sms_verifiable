class HomeController < ApplicationController
  before_action :require_sms_verifiable!, only: [:foo]

  def index
  end

  def foo
  end
end
