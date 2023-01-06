# frozen_string_literal: true

class BaseController < ApplicationController
  def search
    render json: { data: 'A' }
  end
end
