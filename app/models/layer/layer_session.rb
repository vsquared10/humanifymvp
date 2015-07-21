module Layer
  class LayerSession
    # See
    # https://gist.github.com/blakewatters/1e1da150117df226be49

    def initalize
      @header = {
        "Accept"=> "application/vnd.layer+json; version=1.0",
        "Authorization"=>
        "Bearer ofdj7mBOaSNQyqgrxrcqX7NaBC3ZMdaNqTidR6Ezs06bwXj6",
        "Content-Type" => "application/json"}
    end

    def token
      #Auth with Id Token ad Application Id Json object
      response = HTTParty.post(
        'https://api.layer.com/sessions',
        headers: { "Accept"=> "application/vnd.layer+json; version=1.0",
          "Authorization"=>
          "Bearer ofdj7mBOaSNQyqgrxrcqX7NaBC3ZMdaNqTidR6Ezs06bwXj6",
          "Content-Type" => "application/json" },
        body: { "identity_token" => id_token, "app_id" => app_id }.to_json )

      if response['session_token'].nil?
        raise "message: #{response['message']}, identity_token: #{id_token}"
      else
        return response['session_token']
      end
    end

    def app_id
      ENV['LAYER_APP_ID'].to_s
    end

    #Create Id Token
    def id_token
      return IdentityToken.new(user_id: 1,
                        nonce: nonce,
                        expires_at: 2.weeks.from_now).to_s
    end

    private
    #Get Nouce
    def nonce
      response = HTTParty.post(
        'https://api.layer.com/nonces',
        headers: {
          "Accept"=> "application/vnd.layer+json; version=1.0",
          "Authorization"=>
          "Bearer ofdj7mBOaSNQyqgrxrcqX7NaBC3ZMdaNqTidR6Ezs06bwXj6",
          "Content-Type" => "application/json" })

      if response['nonce'].nil? 
        raise "message: #{response['message']}"
      else
        return response['nonce']
      end
    end

  end
end
