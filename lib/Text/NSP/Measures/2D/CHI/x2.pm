=head1 NAME

Text::NSP::Measures::2D::CHI::x2  - Statistical library package to
calculate Pearson's Chi Squared test.

=head1 SYNOPSIS

=head3 Basic Usage

  use Text::NSP::Measures::2D::CHI::x2;

  my $x2 = Text::NSP::Measures::2D::CHI::x2->new();

  my $npp = 60; my $n1p = 20; my $np1 = 20;  my $n11 = 10;

  $x2_value = $x2->calculateStatistic( n11=>$n11,
                                      n1p=>$n1p,
                                      np1=>$np1,
                                      npp=>$npp);

  if( ($errorCode = $x2->getErrorCode()))
  {
    print STDERR $erroCode." - ".$x2->getErrorMessage();
  }
  else
  {
    print $x2->getStatisticName."value for bigram is ".$x2_value;
  }


=head1 DESCRIPTION

Pearson's Chi-squred test measures the devitation between the observed
data and what would be expected if <word1> and <word2> were independent.
The higher the score, the less evidence there is in favor of concluding
that the words are independent.


Assume that the frequency count data associated with a bigram
<word1><word2> is stored in a 2x2 contingency table:

          word2   ~word2
  word1    n11      n12 | n1p
 ~word1    n21      n22 | n2p
           --------------
           np1      np2   npp

where n11 is the number of times <word1><word2> occur together, and
n12 is the number of times <word1> occurs with some word other than
word2, and n1p is the number of times in total that word1 occurs as
the first word in a bigram.

The expected values for the internal cells are calculated by taking the
product of their associated marginals and dividing by the sample size,
for example:

          np1 * n1p
   m11=   ---------
            npp

Then the deviation between observed and expected values for each internal
cell is computed to arrive at the Pearson's Chi-Squared test value:

 Pearson's Chi-Squared = 2 * [((n11 - m11)/m11)^2 + ((n12 - m12)/m12)^2 +
                              ((n21 - m21)/m21)^2 + ((n22 -m22)/m22)^2]


=over

=cut


package Text::NSP::Measures::2D::CHI::x2;


use Text::NSP::Measures::2D::CHI;
use strict;
use Carp;
use warnings;


our ($VERSION, @ISA);

@ISA = qw(Text::NSP::Measures::2D::CHI);

$VERSION = '0.91';


=item calculateStatistic() - method to calculate the Chi-squared value.

INPUT PARAMS  : $count_values       .. Reference of an hash containing
                                       the count valuescomputed by the
                                       count.pl program.

RETURN VALUES : $x2                .. x2 value for this bigram.

=cut

sub calculateStatistic
{
  my $self = shift;
  my %values = @_;

  my $observed;
  my $expected;

  # computes and returns the observed and expected values from
  # the frequency combination values. returns 0 if there is an
  # error in the computation or the values are inconsistent.
  if( !(($observed, $expected) = $self->SUPER::calculateStatistic(\%values)) ) {
    return;
  }
  #  Now calculate the xsquare
  my $Xsquare = 0;

  $Xsquare += $self->computeVal($observed->{n11}, $expected->{m11});
  $Xsquare += $self->computeVal($observed->{n12}, $expected->{m12});
  $Xsquare += $self->computeVal($observed->{n21}, $expected->{m21});
  $Xsquare += $self->computeVal($observed->{n22}, $expected->{m22});

  $Text::NSP::Measures::2D::marginals = undef;

  return $Xsquare;
}



=item getStatisticName() - Returns the name of this statistic

INPUT PARAMS  : none

RETURN VALUES : $name      .. Name of the measure.

=cut

sub getStatisticName
{
  my ($self)=@_;
  return "Chi-squared test";
}



1;
__END__


=back

=head1 AUTHOR

Ted Pedersen,                University of Minnesota Duluth
                             E<lt>tpederse@d.umn.eduE<gt>

Satanjeev Banerjee,          Carnegie Mellon University
                             E<lt>satanjeev@cmu.eduE<gt>

Amruta Purandare,            University of Pittsburgh
                             E<lt>amruta@cs.pitt.eduE<gt>

Bridget Thomson-McInnes,     University of Minnesota Twin Cities
                             E<lt>bthompson@d.umn.eduE<gt>

Saiyam Kohli,                University of Minnesota Duluth
                             E<lt>kohli003@d.umn.eduE<gt>

=head1 HISTORY

Last updated: $Id: x2.pm,v 1.4 2006/04/20 22:26:19 saiyam_kohli Exp $

=head1 BUGS


=head1 SEE ALSO

L<http://groups.yahoo.com/group/ngram/>

L<http://www.d.umn.edu/~tpederse/nsp.html>


=head1 COPYRIGHT

Copyright (C) 2000-2006, Ted Pedersen, Satanjeev Banerjee, Amruta
Purandare, Bridget Thomson-McInnes and Saiyam Kohli

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to

    The Free Software Foundation, Inc.,
    59 Temple Place - Suite 330,
    Boston, MA  02111-1307, USA.

Note: a copy of the GNU General Public License is available on the web
at L<http://www.gnu.org/licenses/gpl.txt> and is included in this
distribution as GPL.txt.

=cut