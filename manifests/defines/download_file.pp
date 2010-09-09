define download_file(
	$site="",
	$cwd="",
	$creates="",
	$require="",
	$user="") {

	exec { $name:
		command => "wget" ${site}/${name}",
		cwd => $cwd,
		creates => $cwd/${name},
		require => [ Package["wget"], $require ],
		user => $user,
	}
}
	
