#!/usr/bin/perl
use strict;
use warnings;
use Net::Twitter;
use Encode;
my $consumer_secret = "";
my $consumer_key = "";
my $access_token = "";
my $access_secret = "";
my $lat = 0;
my $long = 0;
my $place_id = "";

# t > 30
my @Hot = (
    "Hotter than hell", 
    "Targaryen's are coming", 
    "Hitler dice que ya sube", 
    "¡¡Me derritooooo!!", 
    "Nueva marca de saunas en FI-UPM", 
    "Sinners at work",
    "¡Abrid las ventanas o huid!",
    "¿Algún oasis cerca?",
    "Tengo miedo Dave"
    );

#  26 < t <= 30
my @Warm = (
    "Calentito, calentito", 
    "Bajad las persianas cabrones", 
    "El A/C empieza a echarse de menos",
    "Podrían rodar Dune aqui",
    "Hay que ir pensando si abrir las ventanas o no",
    "Alguno está pensando en quitarse los zapatos",
    "Si la humedad fuese más alta esto sería una selva",
    "Alguno se está poniendo la chaqueta del frío que tiene"
    );

# 10 < t <= 20
my @Cold = (
	"Not bad", 
	"The weather today is good, but the air is full of bullshit");

# t <= 10
my @VeryCold = (
	"Cuando el grajo vuela bajo...", 
	"Pingüinos everywhere", 
	"A lot of people like snow. I find it to be an unnecessary freezing of water",
	"Winter is coming"
);

my $nt = Net::Twitter->new(
    traits   => [qw/OAuth API::REST/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $access_token,
    access_token_secret => $access_secret,
    );


# Modify to suit your needs
my $temp = ;

my $tweet = get_Status($temp);

Encode::_utf8_on($tweet);

eval { $nt->update({status=>$tweet, lat=>$lat, long=>$long, place_id=>$place_id})};
if ( $@ )
{
    warn "update failed because: $@\n";
}


sub get_Status
{
    my $temp = shift;

    my $rant = get_rant($temp);

    my $tweet = "Hay $temp grados Celsius - $rant";

    return $tweet;

}

sub get_rant()
{
    my $temp = shift;
    my $rand;
    my $rant;
    if ($temp > 30)
    {
        $rand = rand(@Hot);
        $rant = $Hot[$rand];
    }
    if ($temp <= 30 && $temp > 26)
    {
        $rand = rand(@Warm);
        $rant = $Warm[$rand];
    }
    if ($temp <= 26 && $temp > 20)
    {
	$rant = "Temperatura idónea para trabajar. Congratulémonos";
    }
    if ($temp <= 20 && $temp > 10)
    {
        $rand = rand(@Cold);
        $rant = $Cold[$rand];
    }
    if ($temp <= 10)
    {
        $rand = rand(@VeryCold);
        $rant = $VeryCold[$rand];
    }

    return $rant;
}
