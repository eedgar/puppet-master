define download_file(
	$site="",
	$cwd="",
	$creates="",
	$require="",
	$http_user="",
	$http_pass="",
	$user="") {

	if $http_user and $http_pass {
		exec { "wget-$name":
			command => "wget wget --http-user='${http_user}' --http-password='${http_pass}' ${site}/${name}",
			cwd => $cwd,
			creates => "${cwd}/${name}",
			require => [ Package["wget"], $require ],
			user => $user,

	} else {
		exec { "wget-$name":
			command => "wget ${site}/${name}",
			cwd => $cwd,
			creates => "${cwd}/${name}",
			require => [ Package["wget"], $require ],
			user => $user,
		}
	}
}
	
