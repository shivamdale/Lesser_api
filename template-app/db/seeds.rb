# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_role = BxBlockRolesPermissions::AdminRole.find_or_initialize_by(name:'SuperAdmin')
admin_role.save
AdminUser.create(email: "admin@example.com",password:"Password",password_confirmation:"Password", admin_role_id: admin_role.id)