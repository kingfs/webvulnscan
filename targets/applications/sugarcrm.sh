SUGAR_DB_USER="usr_sugarcrm"
SUGAR_DB_USER_PASSWORD="wvs"
SUGAR_DB_NAME="db_sugarcrm"
SUGAR_INSTALL_FOLDER="sugarcrm"
SUGAR_VERSION="6.5.16"

#wget http://www.sugarforge.org/frs/download.php/10951/SugarCE-$SUGAR_VERSION.zip -O $TMPDIR/#sugarcrm.zip -c
#unzip -qq $TMPDIR/sugarcrm.zip -d $INSTALL_DIR
#mv $INSTALL_DIR/SugarCE-Full* $INSTALL_DIR/$SUGAR_INSTALL_FOLDER

# Create config-file
echo "<?php \$sugar_config_si = array(
'setup_db_host_name' => 'localhost',
'setup_db_sugarsales_user' => '$SUGAR_DB_USER',
'setup_db_sugarsales_password' => '$SUGAR_DB_USER_PASSWORD',
'setup_db_database_name' => '$SUGAR_DB_NAME',
'setup_db_type' => 'mysql',
'setup_db_pop_demo_data' => false,
'setup_db_create_database' => 1,
'setup_db_create_sugarsales_user' => 1,
'setup_db_admin_user_name' => 'root',
'setup_db_admin_password' => '',
'setup_db_drop_tables' => 0,
'setup_db_username_is_privileged' => true,
'dbUSRData' => 'create',
'setup_site_url' => 'http://wvs.localhost/$SUGAR_INSTALL_FOLDER',
'setup_site_admin_user_name'=>'admin',
'setup_site_admin_password' => 'admin',
'setup_site_sugarbeet_automatic_checks' => true, 
'default_currency_iso4217' => 'EUR',
'default_currency_name' => 'EUR Euro',
'default_currency_significant_digits' => '2',
'default_currency_symbol' => '€',
'default_date_format' => 'Y-m-d',
'default_time_format' => 'H:i',
'default_decimal_seperator' => '.',
'default_export_charset' => 'utf-8',
'default_language' => 'en_us',
'default_locale_name_format' => 's f l',
'default_number_grouping_seperator' => ',',
'export_delimiter' => ',',
'setup_license_key' => 'LICENSE_KEY', 
'setup_system_name' => 'SugarCRM - WVS Test',
);" | sudo tee $INSTALL_DIR/$SUGAR_INSTALL_FOLDER/config_si.php >/dev/null

mysql -uroot -e "
    DROP DATABASE IF EXISTS $SUGAR_DB_NAME;
    CREATE DATABASE IF NOT EXISTS $SUGAR_DB_NAME;
    GRANT ALL PRIVILEGES ON "$SUGAR_DB_NAME".* TO '$SUGAR_DB_NAME'@'localhost' IDENTIFIED BY '$SUGAR_DB_USER_PASSWORD';
    FLUSH PRIVILEGES;"


cd $INSTALL_DIR/$SUGAR_INSTALL_FOLDER

sudo chown www-data:www-data * -R

#sudo php -f install.php?goto=SilentInstall&cli=true
