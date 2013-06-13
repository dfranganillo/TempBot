#!/usr/bin/perl
use strict;
use warnings;
use Net::Twitter;
use Encode;
use Image::Imgur;

my $consumer_secret = "";
my $consumer_key = "";
my $access_token = "";
my $access_secret = "";

my $lat = ;
my $long = ;
my $place_id = "";
my $get_image = "mplayer tv:// -tv driver=v4l2:device=/dev/video0:width=1600:height=1200:outfmt=rgb24 -frames 3 -vo jpeg";

my $nt = Net::Twitter->new(
    traits   => [qw/OAuth API::RESTv1_1/],
    consumer_key        => $consumer_key,
    consumer_secret     => $consumer_secret,
    access_token        => $access_token,
    access_token_secret => $access_secret,
    );

system($get_image);

my $key = ""; # dev key
my $img_up = new Image::Imgur(key => $key);
my $url = $img_up->upload('00000002.jpg');

my $tweet = "Imagen capturada : ".$url;

Encode::_utf8_on($tweet);

eval { $nt->update({status=>$tweet, lat=>$lat, long=>$long, place_id=>$place_id})};
if ( $@ )
{
    warn "update failed because: $@\n";
}
