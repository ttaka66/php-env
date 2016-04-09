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

execute "create-database-user" do
  user "postgres"
  exist = <<-EOH
  psql -U postgres -c "select * from pg_user where usename='#{node['postgresql']['user']}'" | grep -c #{node['postgresql']['user']}
  EOH
  command "createuser -U postgres -SdR #{node['postgresql']['user']}"
  not_if exist
end
