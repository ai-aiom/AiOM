# cat install.sh 
#!/bin/bash
install_dir=/home/aiom-install
if [[ -e $install_dir ]];then
    rm -rf $install_dir
else
    mkdir -p $install_dir
fi
sed -n '1,/^exit 0$/!p' $0 >$install_dir/aiom.tar.gz

cd $install_dir
tar -xzvf aiom.tar.gz
rm -rf /usr/local/lib/tomcat/webapps/aiom*
cp aiom.war /usr/local/lib/tomcat/webapps

if [[ -e /etc/aiom ]];then
    rm -rf /etc/aiom/*
else
    mkdir /etc/aiom
fi

cp conf/* /etc/aiom
cp init.d/aiom /etc/rc.d/init.d

chmod 755 /etc/rc.d/init.d/aiom
chkconfig aiom on

path=$(pwd)
mysql -uroot << EOF
source $path/sql/create_database.sql;
use aiom
source $path/sql/create_objects.sql;
source $path/sql/init_data.sql;
EOF

rm -rf $install_dir

exit 0
