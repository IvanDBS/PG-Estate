class CspReportsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if request.body.read.present?
      Rails.logger.warn("CSP Violation: #{request.body.read}")
    end
    head :ok
  end
end 