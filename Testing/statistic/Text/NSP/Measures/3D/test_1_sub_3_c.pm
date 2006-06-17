package Text::NSP::Measures::3D::test_1_sub_3_c;
use Text::NSP::Measures::3D;
use strict;

our ($VERSION, @ISA);

@ISA = qw(Text::NSP::Measures::3D);

$VERSION = '0.93';


sub new
{
  my $class = shift;
  my $this = {};

  $class = ref $class || $class;

  $this->{errorMessage} = '';
  $this->{errorCodeNumber} = 0;
  $this->{traceOutput} = '';
  if ($class eq 'Text::NSP::Measures::3D::MI')
  {
    $this->{errorMessage} .= "\nError (${class}::new()) - ";
    $this->{errorMessage} .= "This class is intended to be an abstract base class.";
    $this->{errorMessage} .= "Your class should override it.";
    $this->{errorCodeNumber} = 100;
  }
  elsif ($class eq 'Text::NSP::Measures::3D::CHI')
  {
    $this->{errorMessage} .= "\nError (${class}::new()) - ";
    $this->{errorMessage} .= "This class is intended to be an abstract base class.";
    $this->{errorMessage} .= "Your class should override it.";
    $this->{errorCodeNumber} = 100;
  }
  elsif ($class eq 'Text::NSP::Measures::3D::Fisher')
  {
    $this->{errorMessage} .= "\nError (${class}::new()) - ";
    $this->{errorMessage} .= "This class is intended to be an abstract base class.";
    $this->{errorMessage} .= "Your class should override it.";
    $this->{errorCodeNumber} = 100;
  }
  bless $this, $class;
  return $this;
}


sub calculateStatistic { return 0; }

1;
