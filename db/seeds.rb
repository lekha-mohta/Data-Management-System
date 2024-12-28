# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Groups Table

User.create!(
  username: 'ace22ah',
  email: 'ahegde1@sheffield.ac.uk',
  sn: 'Hegde',
  givenname: 'Atri',
  mail: 'ahegde1@sheffield.ac.uk',
  ou: 'COM',
  account_type: 'student - ug',
  role: 'admin'
)
User.create!(
  username: 'acb22at',
  email: 'atse1@sheffield.ac.uk',
  sn: 'Tse',
  givenname: 'Annie',
  mail: 'atse1@sheffield.ac.uk',
  ou: 'COM',
  account_type: 'student - ug',
  role: 'admin'
)

User.create!(
  username: 'acd22jh',
  email: 'jhargreaves3@sheffield.ac.uk',
  sn: 'Hargreaves',
  givenname: 'Joffray',
  mail: 'jhargreaves3@sheffield.ac.uk',
  ou: 'COM',
  account_type: 'student - ug',
  role: 'admin'
)

User.create!(
  username: 'me1wb',
  email: 'w.birtwistle@sheffield.ac.uk',
  sn: 'Birtwistle',
  givenname: 'Wendy',
  mail: 'w.birtwistle@sheffield.ac.uk',
  ou: 'MEC',
  account_type: 'staff',
  role: 'admin'
)

User.create!(
  username: 'acd22lm',
  email: 'lmohta1@sheffield.ac.uk',
  sn: 'Mohta',
  givenname: 'Lekha',
  mail: 'lmohta1@sheffield.ac.uk',
  ou: 'COM',
  account_type: 'student - ug',
  role: 'admin'
)

Group.create!(
  name: 'Confidential',
  description: 'Do not share with others!'
)

Group.create!(
  name: 'Commercially Available',
  description: 'Available for purchase commercially!'
)

# Machine
Machine.create!(
  name: 'P100 (LS)',
  description: 'One of the machines provided to us',
  archived: false,
  created_by: User.first,
  modified_by: User.first,
  created_at: Time.current,
  updated_at: Time.current
)

Machine.create!(
  name: 'VX200 (HSS)',
  description: 'One of the machines provided to us',
  archived: false,
  created_by: User.second,
  modified_by: User.second,
  created_at: Time.current,
  updated_at: Time.current
)

Machine.create!(
  name: 'Sintratec (LS)',
  description: 'One of the machines provided to us',
  archived: false,
  created_by: User.second,
  modified_by: User.second,
  created_at: Time.current,
  updated_at: Time.current
)

Machine.create!(
  name: 'Scintilla (HSS)',
  description: 'One of the machines provided to us',
  archived: false,
  created_by: User.second,
  modified_by: User.second,
  created_at: Time.current,
  updated_at: Time.current
)

# Parameter

Parameter.create!(
  name: 'Bed Temperature',
  unit: '°C',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Hatching Laser Power',
  unit: 'W',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Edges & Contours',
  unit: 'N/A',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Edges & Contours Laser Power',
  unit: 'N/A',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Hatching Laster Speed',
  unit: 'mm/s',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Edges & Contours Laser Speed',
  unit: 'mm/s',
  created_at: Time.current,
  updated_at: Time.current
)

Parameter.create!(
  name: 'Scan Spacing',
  unit: 'mm/s',
  created_at: Time.current,
  updated_at: Time.current
)

# MachineParameters

Parameter.all.each do |parameter|
  MachineParameter.create!(
    parameter:,
    machine: Machine.first
  )
end

parameters = [
  { name: 'Aperture Height', unit: 'mm' },
  { name: 'Emissivity', unit: 'N/A' },
  { name: 'Part Bed Temperature', unit: '°C' },
  { name: 'Initial Overhead Power', unit: '%' },
  { name: 'Warm-up Duration', unit: 'mins' },
  { name: 'Recoat Speed', unit: 'mm/s' },
  { name: 'Recoat Power', unit: '%' },
  { name: 'Hopper Refill Frequency', unit: 'Layers' },
  { name: 'Sinter Lamp Power', unit: 'kW' },
  { name: 'Sinter Speed', unit: 'mm/s' },
  { name: 'Ink Density', unit: 'DPD' },
  { name: 'Removal Temperature', unit: '°C' }
]

# Get the second machine
second_machine = Machine.second

# Initialize an empty array to store the parameters
second_machine_params = []

parameters.each do |param|
  # Create the parameter and store it in the array
  second_machine_params << Parameter.create!(
    name: param[:name],
    unit: param[:unit],
    created_at: Time.current,
    updated_at: Time.current
  )
end

# Iterate over the array and create a MachineParameter for each parameter
second_machine_params.each do |parameter|
  MachineParameter.create!(
    parameter:,
    machine: second_machine
  )
end

parameters = [
  { name: 'Layer Height', unit: 'µm' },
  { name: 'Number of Perimeters', unit: 'N/A' },
  { name: 'Perimeter Offset', unit: 'µm' },
  { name: 'Hatching Offset', unit: 'µm' },
  { name: 'Hatching Spacing', unit: 'µm' },
  { name: 'Surface Pre-heat Temperature', unit: '°C' },
  { name: 'Chamber Pre-heat Temperature', unit: '°C' },
  { name: 'Laser Speed', unit: 'mm/s' }
]

# Get the third machine
third_machine = Machine.third

# Initialize an empty array to store the parameters
third_machine_params = []

parameters.each do |param|
  # Create the parameter and store it in the array
  third_machine_params << Parameter.create!(
    name: param[:name],
    unit: param[:unit],
    created_at: Time.current,
    updated_at: Time.current
  )
end

# Iterate over the array and create a MachineParameter for each parameter
third_machine_params.each do |parameter|
  MachineParameter.create!(
    parameter:,
    machine: third_machine
  )
end

parameters = [
  { name: 'Custom Build?', unit: 'N/A' },
  { name: 'Reproduction File', unit: 'N/A' },
  { name: 'Warm-up Target Temperature', unit: '°C' }
]
# Get the fourth machine
# fourth_machine = Machine.where(name: 'Scintilla (HSS)').first
fourth_machine = Machine.fourth

# Initialize an empty array to store the parameters
fourth_machine_params = []

parameters.each do |param|
  # Create the parameter and store it in the array
  fourth_machine_params << Parameter.create!(
    name: param[:name],
    unit: param[:unit],
    created_at: Time.current,
    updated_at: Time.current
  )
end

# Iterate over the array and create a MachineParameter for each parameter
fourth_machine_params.each do |parameter|
  MachineParameter.create!(
    parameter:,
    machine: fourth_machine
  )
end

MachineParameter.create!(
  parameter: Parameter.where(name: 'Hopper Refill Frequency').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Part Bed Temperature').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Emissivity').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Recoat Speed').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Recoat Power').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Initial Overhead Power').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Removal Temperature').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Sinter Lamp Power').first,
  machine: fourth_machine
)
MachineParameter.create!(
  parameter: Parameter.where(name: 'Sinter Speed').first,
  machine: fourth_machine
)
