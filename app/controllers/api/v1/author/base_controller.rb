class Api::V1::Author::BaseController < Api::V1::BaseController
  before_action :authenticate_request!
end
