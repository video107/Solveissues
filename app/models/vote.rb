class Vote < ActiveRecord::Base

  belongs_to :user, :dependent => :destroy;
  belongs_to :issue, :counter_cache => true, :dependent => :destroy;
end
