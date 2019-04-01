class User < ApplicationRecord
  include Concerns::Authenticatable
  include Concerns::Confirmable
  include Concerns::Recoverable

end
