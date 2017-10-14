class User < ActiveRecord::Base
	#need to require the bcrypt gem
	has_secure_password

end
