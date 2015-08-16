require 'mysql2'

SCHEDULER.every '10s', :first_in => 0 do |job|

  # Myql connection
  db = Mysql2::Client.new(:host => "dbcluster", :username => "webmaster", :password => "4EccMZ8JMu93Y8RQ", :port => 3306, :database => "tracking_umayor" )

  # Mysql query
  sql = "select idnombreformulario as formulario, count(*) as total from datosformularios where idnombreformulario=421 group by idnombreformulario"

  # Execute the query
  results = db.query(sql)

  # Sending to List widget, so map to :label and :value
  acctitems = results.map do |row|
    row = {
      :label => row['formulario'],
      :value => row['total']
    }
  end

  # Update the List widget
  send_event('um', { items: acctitems } )

end