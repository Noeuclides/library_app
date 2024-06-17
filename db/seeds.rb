User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password').add_role(:admin)
User.create!(email: 'librarian@example.com', password: 'password',
             password_confirmation: 'password').add_role(:librarian)
