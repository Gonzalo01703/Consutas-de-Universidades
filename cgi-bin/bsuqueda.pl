#!"c:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;



print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="utf-8"> 
    <link rel="stylesheet" type="text/css" href="../estilo.css">
    <title>Búsquedas bibliográficas de Programación Web 1 </title>
  </head>
<body>
HTML
my $q = CGI->new;
my $kind = $q->param("kind");
my $keyword = $q->param("keyword");
my $flag;
if(!($kind eq "") && !($keyword eq "")){
  open(IN,"../data/data.txt") or die "<h1>ERROR: open file</h1>\n";
  while(my $line = <IN>){
    my %dict = matchLine($line);
    my $value = $dict{$kind};
    if(defined($value) && $value =~ /.*$keyword.*/){
      print "<h1>Encontrado: $line</h1>\n";
      $flag = 1;
      next; #continue the loop
    }
  }
  close(IN);
}
if(!defined($flag)){
  print "<h1>No encontrado</h1>\n";
}
print <<HTML;
    Ingrese <a href="../consulta.html">aqui</a> para regresar al formulario de búsqueda
  </body>
</html>
HTML
# line, return a hash array.
sub matchLine{
  my %dict = ();
  my $line = $_[0];
  if( $line =~ /^\[([0-9]+)\] ((.+), )?(.+); ((.+)|(http.+));(.+)\./ ){
    $dict{"number"} = $1;
    #$2 include the colon
    if(defined($3)){ #algunos items no tienen autor
      $dict{"author"} = $3;
    }
    $dict{"title"} = $4;
    $dict{"editor"} = $5;
    #$6 es la misma que $5, por opción |
    #$7 es todas las opciones
    $dict{"year"} = $8;
  }else{
    print "<h1>Error la linea no hace match: $line</h1>\n";
  }
  return %dict;
}
