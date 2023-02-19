records = @records
json.data records do |record|
   json.time_range record[0]
   json.no_of_bottle record[1]
end