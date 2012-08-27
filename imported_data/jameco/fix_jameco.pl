#!/usr/bin/perl

my @header = qw/part_id quantity supplier_partno manu_partno cost price supplier_desc group value/;
print join("\t", @header), "\n";

while(my $l = <>) {
  my @A = split(" ", $l);
  my $cost = pop @A;
  my $price = pop @A;
  my $n = pop @A;
  my $jamecono = shift @A;

  my $d = join(" ", @A);

  my ($t, $v, $junk) = split(",", $d, 3);

  my @data = ("", $n, $jamecono, $jamecono, $cost, $price, $d, lc($t), lc($v));

  @data = map { s/[\t"]/ /g; $_ } @data;
  @data = map { $_ =~ /^[\d\.]+$/ ? $_ : "\"$_\"" } @data;

  print join("\t", @data), "\n";

}
