class Build {
	method build($dist-path) {

		my $ract = '.ract-config';
		my $main = 'Scotland-2007.csv';
		my $extras = 'Extras.csv';

		#| mkdir will use existing if present
		mkdir "$*HOME/$ract";

		copy "resources/$main",   "$*HOME/$ract/$main";
		copy "resources/$extras", "$*HOME/$ract/$extras";

		exit 0
	}
}
