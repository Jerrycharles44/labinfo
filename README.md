# Sinatra LabInfo app

This app was built with Sinatra, extended with [Rake tasks](https://github.com/ruby/rake) for working with an SQL database using [ActiveRecord ORM](https://github.com/rails/rails/tree/master/activerecord). 

The LabInfo app provides a database and web interface for users to:
* Sign up as a student or workshop leader
* Users can review all workshops and users available
* Each user can **ONLY** modify content of their own workshop/registration:
* An workshop leader can create, read, update, and delete (CRUD) a workshop
* A student can create, read, update, and delete (CRUD) a workshop registration
* User inputs are validated for account/workshop/registration creation

## Usage

After checking out the repo, run ```bundle install``` to install Ruby gem dependencies.

You can start one of Rack's supported servers using the [shotgun](https://github.com/rtomayko/shotgun) command ```shotgun```

Shotgun can be used as an alternative to the complex reloading logic provided by web frameworks or in environments that don't support application reloading.

## Model Classes
The LabInfo app database includes three model classes: ```User, Workshop, UserWorkshop```

1. User: stores user attributes, including:
* Full Name
* Username
* Email
* Password (Secured with [Bcrypt](https://github.com/codahale/bcrypt-ruby) hashing algorithm)
* Biography
* Workshop_leader, a boolean value to indicate if a user is an workshop leader

2. Workshop: stores workshop attributes, including:
* Name
* Descirption
* Icon, a string value that is commonly an emoji 📚
* Level, indicates workshop difficulty (Beginner == 0, Intermediate == 1, Advance == 2)
* workshop_leader_id, to associate workshop with an workshop leader

3. UserWorkshop: stores student workshop registrations attributes, including: 
* Confirmation, indicates registration status (Pending == 0, Waitlist == 1, Enrolled == 2)
* Notes, student's request to enroll in a workshop
* User_id, to associate registration with a student
* Workshop_id, to associate registration with a workshop

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

