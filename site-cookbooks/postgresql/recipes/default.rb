package "postgresql" do
  action :install
end

package "postgresql-server" do
  action :install
end

execute "postgresql-init" do
  not_if "test -f /var/lib/pgsql/data/postgresql.conf"
  command "service postgresql initdb"
  action :run
end

service "postgresql" do
  action [:enable, :start]
end
