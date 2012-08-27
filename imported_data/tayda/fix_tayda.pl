#!/usr/bin/perl

my @header = qw/part_id quantity supplier_partno manu_partno cost price supplier_desc group value/;
print join("\t", @header), "\n";

while(my $l = <>) {
  my @A = split(" ", $l);
  my $cost = pop @A;
  $cost =~ s/\$//;
  my $junkeq = pop @A; undef $junkeq;

  my $price = pop @A;
  $price =~ s/\$//;
  my $junkat = pop @A; undef $junkat;

  my $n = shift @A;
  my $taydano = "0";

  my $d = join(" ", @A);

  my $t = "";
  my $v = "";

  my @data = ("", $n, $taydano, $taydano, $cost, $price, $d, lc($t), lc($v));

  @data = map { s/[\t"]/ /g; $_ } @data;
  @data = map { $_ =~ /^[\d\.]+$/ ? $_ : "\"$_\"" } @data;

  print join("\t", @data), "\n";

}
