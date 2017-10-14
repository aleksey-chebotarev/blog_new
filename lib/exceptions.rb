module Exceptions
  class NotAuthenticatedError      < StandardError; end
  class NotAuthorizedError         < StandardError; end
  class AuthenticationTimeoutError < StandardError; end
end
