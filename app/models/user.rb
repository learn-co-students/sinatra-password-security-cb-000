class User < ActiveRecord::Base
	has_secure_password # this macro gives access to special methods which use the bcrypt gem
			# It gives access to password method, even though there is no such column in the User table;
			# it also gives access to #authenticate method
end
