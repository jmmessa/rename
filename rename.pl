#!/usr/bin/perl
sub explore {
	my ($dir) = @_;
	print "Exploring $dir\n";
	opendir(D,$dir);
	my $vid;
	my $srt;
	foreach (readdir D) {
		my $file = $_;
 		next if ($file eq ".");
 		next if ($file eq "..");
		if ( -d  "$dir/$file") {
			explore("$dir/$file");
		}
    	$vid=$_ if (/\.mp4$/);
    	$vid=$_ if (/\.mkv$/);
    	$vid=$_ if (/\.avi$/);
    	$srt=$_ if (/\.srt$/);
		my $vid_root=$vid;
		$vid_root=~s/^(.*)\..*/$1/;
		if ($srt && $vid) {
			my $newsrt=$srt;
			$newsrt=~s/^.*\./$vid_root./;
			rename("$dir/$srt", "$dir/$newsrt");
			print ".... Renommage : $srt ====> $newsrt\n";
			return;
		}
	}
}

explore(".");