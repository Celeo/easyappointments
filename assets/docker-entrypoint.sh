#!/bin/bash

cp config-sample.php config.php

sed -i "s|const BASE_URL      = 'http://url-to-easyappointments-directory';|const BASE_URL      = '$BASE_URL';|g" config.php
sed -i "s|const LANGUAGE      = 'english';|const LANGUAGE      = '$LANGUAGE';|g" config.php
sed -i "s|const DEBUG_MODE    = FALSE;|const DEBUG_MODE    = $DEBUG_MODE;|g" config.php

sed -i "s|const DB_HOST       = 'localhost';|const DB_HOST       = '$DB_HOST';|g" config.php
sed -i "s|const DB_NAME       = 'easyappointments';|const DB_NAME       = '$DB_NAME';|g" config.php
sed -i "s|const DB_USERNAME   = 'root';|const DB_USERNAME   = '$DB_USERNAME';|g" config.php
sed -i "s|const DB_PASSWORD   = 'root';|const DB_PASSWORD   = '$DB_PASSWORD';|g" config.php

sed -i "s|const SMTP_HOST   = '';|const SMTP_HOST   = '$SMTP_HOST';|g" config.php
sed -i "s|const SMTP_USER   = '';|const SMTP_USER   = '$SMTP_USER';|g" config.php
sed -i "s|const SMTP_PASS   = '';|const SMTP_PASS   = '$SMTP_PASS';|g" config.php

apache2-foreground
