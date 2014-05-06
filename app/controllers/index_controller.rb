# This controller responds to root requests and initializes the
# ChaplinJS app. It is NOT part of the API.

class IndexController < ApplicationController
  respond_to :html

  def index
  end
end
