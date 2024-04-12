class Build {
	method build($dist-path) {

		my $ract = '.ract-config';
		my $file = 'Scotland-2007.csv';

		#| mkdir will use existing if present
		mkdir "$*HOME/$ract";

		copy "resources/$file", "$*HOME/$ract/$file";

		exit 0
	}
}
