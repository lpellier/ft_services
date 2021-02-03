<?php
/*n sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <https://docs.phpmyadmin.net/>.
 *
 * @package PhpMyAdmin
 */

$cfg['blowfish_secret'] = 'zuTZHZA/[r011PM[lHf{j.v3QGJo:F;H';

$i = 0;
$i++;

$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'mysql';
$cfg['Servers'][$i]['port'] = 3306;

$cfg['Servers'][$i]['compress'] = false;

$cfg['PmaAbsoluteUri'] = 'http://192.168.49.2/phpmyadmin/';

$cfg['TempDir'] = '/usr/share/webapps/phpmyadmin/tmp';

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
