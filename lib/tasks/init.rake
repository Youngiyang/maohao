namespace :init do
  task :regions_setup => [:environment] do
    def create_regions(regions, parent_id, depth)
      regions.each do |region|
        region_mod = Region.create!(encoding: region['encoding'], name: region['name'], parent_id: parent_id, depth: depth)
        if region['children']
          create_regions(region['children'], region_mod.id, depth+1)
        end
      end
    end
    region_file = Rails.root.join('db', 'regions.json')
    regions = []
    File.open(region_file, 'r') do |f|
      regions = JSON.parse(f.read)
    end
    create_regions(regions, 0, 1)
  end
end
