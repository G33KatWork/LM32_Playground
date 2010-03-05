#!/usr/bin/perl
use strict;
use Getopt::Long;
use Pod::Usage;

my $action;
my $address;
my $size;

my $arglen = $#ARGV;
pod2usage(1) if (!GetOptions('action=s' => \$action, 'address=o' => \$address, 'size=o' => \$size) || $arglen != 2);
pod2usage("$0: Unknown action") if ($action ne 'd' && $action ne 'u');

binmode STDOUT;

#Print header: <action><address><size>
print($action);
print(pack("N", $address));
print(pack("N", $size));

#Print data to be uploaded to the bootloader if desired
if($action eq 'u') {
	binmode STDIN;
	my $byte;
	while(read(STDIN, $byte, 1) && !eof(STDIN)) {
		print $byte;
	}
}

__END__

=head1 NAME

cmd_generate - A command sequence generator for the LM32 bootloader

=head1 SYNOPSIS

cmd_generate [options]

Example: cmd_generate --action=d --address=0x40000000 --size=0x1000

=head1 OPTIONS

=over 8

=item B<--action>

Defines the action which will be executed. This is either a 'd' for downloading data from the bootloader or 'u' for uploading data to the bootloader

=item B<--address>

Defines the beginning address of the data which should be downloaded
or uploaded.

=item B<--size>

Defines the size of the data chunk to be uploaded or downloaded

=back

=head1 DESCRIPTION

B<This program> is used to generate command sequences which can be send to the LM32 Bootloader.

=cut
