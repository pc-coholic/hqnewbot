use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use Irssi::UI;
use Irssi::Irc;
use Switch;
use utf8;

$VERSION = '1.00';
%IRSSI = (
    authors     => 'Martin Gross',
    contact     => 'martin@pc-coholic.de',
    name        => 'HQnew',
    description => 'Update hq-state ',
    license     => 'Public Domain',
    url		=> 'http://www.pc-coholic.de/',
);


#--------------------------------------------------------------------
# Process incoming messages
#--------------------------------------------------------------------
sub process_incoming {
	my ($server, $msg, $nick, $address, $target) = @_;

	my $req = substr($msg, 0, 5);
	if (($req eq '!upup') || ($req eq '!upzu') || ($req eq '!zuup') || ($req eq '!zuzu')) {
		process_command($server, $target, $req);
	}
}

#--------------------------------------------------------------------
# Count hubels and do stuff
#--------------------------------------------------------------------
sub process_command() {
	my ($server, $target, $status) = @_;
	
	my $channel = Irssi::Irc::Server->channel_find($target);
	my $topic = $channel->{topic};

	if (($target eq "#ccc") || ($target eq "#mqmw") || ($target eq "#hqtest")) {
		my $hqold = substr($status, 1, 2);
		my $hqnew = substr($status, 3, 2);
		$topic =~ s/hq:old (up|zu)/hq:old $hqold/gi;
		$topic =~ s/hq:new (up|zu)/hq:new $hqnew/gi;
		#print $topic;
		$server->command("/topic $target $topic");
	}
}
Irssi::signal_add("message public", "process_incoming");

