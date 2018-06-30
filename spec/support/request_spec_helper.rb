module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def login(user)
    post api_v1_user_session_path, params:  { email: user.email, password: '123456'}
  end

  def get_headers_from_response(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid =   response.headers['uid']

    headers = { 'access-token' => token, 'client' => client,
                'uid' => uid, 'expiry' => expiry, 'token_type' => token_type }
  end
end