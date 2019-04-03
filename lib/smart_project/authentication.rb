module SmartProject::Authentication
  class User
    attr_reader :smart_token, :id, :email, :type

    def initialize(smart_token)
      @smart_token = smart_token
      @jwt = smart_token.jwt
      @payload = smart_token.payload
      @id = payload['sub'] || payload['id']
      @email = payload['email']
      @type = payload['type']
    end

    def super_admin?
      type == 'SuperAdmin'
    end

    def admin?
      type == 'Admin' || super_admin?
    end

    def operator?
      type == 'Operator' || admin?
    end
  end

  class SuperAdmin < User
    def full_name
      'super admin'
    end
  end

  class Operator < User
    attr_reader :company_id, :roles
    def initialize(smart_token)
      super(smart_token)
      @company_id = payload['company_id']
      @roles = payload['roles']
    end
  end

  class Admin < User
    attr_reader :modules
    def initialize(smart_token)
      super(smart_token)
      @modules = payload['modules']
    end
  end
end
