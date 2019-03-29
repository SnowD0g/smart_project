module SmartProject::Authentication
  class User
    attr_reader :id, :email, :type

    def initialize(attributes)
      @id = attributes['sub'] || attributes['id']
      @email = attributes['email']
      @type = attributes['type']
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
    def initialize(attributes)
      super(attributes)
      @company_id = attributes['company_id']
      @roles = attributes['roles']
    end
  end

  class Admin < User
    attr_reader :modules
    def initialize(attributes)
      super(attributes)
      @modules = attributes['modules']
    end
  end
end
