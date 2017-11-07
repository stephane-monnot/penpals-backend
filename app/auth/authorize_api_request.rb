class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    {
        user: user
    }
  end

  attr_reader :headers

  private

  def user
    # check if user is in the database
    # memoize user object
    @user ||=User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(ExceptionHandler::InvalidToken, "#{ResponseMessage.invalid_token} #{e.message}")
  end

  # decode authentification token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, ResponseMessage.missing_token)
  end
end
