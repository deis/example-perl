	#!/usr/bin/env plackup

	my $app = sub {
			my $env = shift;
			
			return [
				200,
				['Content-Type', 'text/plain'],
				[ sprintf('Powered by %s', $ENV{'POWERED_BY'} || 'Ben') ],
			];

	};