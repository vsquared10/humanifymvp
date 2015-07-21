module Layer
  class IdentityToken
    attr_reader :user_id, :nonce, :expires_at

    def initialize(options = {})
      @user_id = options[:user_id]
      @nonce = options[:nonce]
      @expires_at = (options[:expires_at] || 2.weeks.from_now)
      @jwt = JSON::JWT.new(claim)
      @jwt.header['typ'] = 'JWT'
      @jwt.header['cty'] = 'layer-eit;v=1'
      @jwt.header['kid'] = layer_key_id
    end
    
    def to_s
      @jwt.sign(private_key, :RS256).to_s
    end
    
    def layer_key_id
      ENV['LAYER_KEY_ID']
    end
    
    def layer_provider_id
      ENV['LAYER_PROVIDER_ID']
    end
    
    private
    def claim
      {
        iss: layer_provider_id,
        prn: user_id.to_s,
        iat: Time.now.to_i,
        exp: expires_at.to_i,
        nce: nonce
      }
    end

    def private_key
      # NOTE: When saving RSA Private Key as a string, escape line breaks with \n.
      OpenSSL::PKey::RSA.new(Base64.decode64(ENV['LAYER_PRIVATE_KEY']))
    end
  end
end
