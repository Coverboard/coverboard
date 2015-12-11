# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Project.create name: 'sample', uid: 'qwerty123456'
Project.create name: 'with-random-uid'



demo_project = Project.create name: 'demo', uid: 'demo'

time = DateTime.now.strftime('%s')

20.times do |delta|
  Metric::NAMES.each do |metric|
    Metric.create name: metric, value: rand(100), timestamp: time.to_i + 1000*delta, project: demo_project
  end
end


