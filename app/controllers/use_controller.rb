class UseController < ApplicationController
  skip_before_action :require_login, only: %i[use]
  def use; end
end
