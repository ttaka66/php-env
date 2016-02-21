%w{php-fpm php-pecl-zendopcache}.each do |pkg|
	package pkg do
		action :install
		notifies :restart, "service[php-fpm]"
	end
end

service "php-fpm" do
	action [:enable, :start]
end