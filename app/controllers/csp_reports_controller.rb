class CspReportsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    Rails.logger.warn("CSP Violation: #{request.body.read}") if request.body.read.present?
    head :ok
  end
end
