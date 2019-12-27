class Post < ActiveRecord::Base
  include Cloaked

  with_cloaked_keys :public_id
end