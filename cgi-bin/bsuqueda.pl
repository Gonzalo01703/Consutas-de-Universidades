#!C:\xampp\perl\bin\perl.exe
use strict;
use warnings;

use CGI;
my $q= CGI->new;
print $q->header('text/html','utf-8');
my $tipo= $q->param("kind");
my $valor= $q->param("keyword");
$valor = uc($valor); 

my $exp = buildRegex(22);


my @universidades = buscador($tipo,$valor); 

my @campos = ("nombre","periodo","departamento","denominacion");

my $table = renderTable();
renderHTML("estilo.css",$table);

sub renderTable{
  $table = "<table border='2'>\n";
  $table.= "<tr>\n";
  foreach my $aux(@campos){
    $table.= "<th>".$aux."</th>\n";
  }
  $table.= "</tr>\n";
  foreach my $uni (@universidades){
      $table.= "<tr>\n";
      foreach my $campo (@campos){
          $table.= "<td>".%{$uni}{$campo}."</td>\n";  
      }
      $table.= "</tr>\n";
  }
  $table.= "</table>\n";
}
sub renderHTML{
  my $css = $_[0];
  my $body = $_[1];
  print <<BLOCK;
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"> 
  <link rel="stylesheet" type="text/css" href="estilo.css">
  <title>Consultas  </title>
</head>
<body>
$body
</body>
</html>
BLOCK

}

sub buscador{
  my $kind = $_[0];
  my $keyword = $_[1];
  my @universidades=();
  
  open(IN, "../Programas.csv" ) or die("Error al abrir el archivo");
  my @registros = <IN>;
  close(IN);

  my $cont=0;
  my $universidad;
  for(my $i=0;$i<@registros;$i++){
    if($registros[$i] =~ /$exp/){
      if(defined($2) && defined($5)&& defined($11)&& defined($17)){
        $universidad ={
          "nombre" => $2,
          "periodo" => $5,
          "departamento" => $11,
          "denominacion" => $17,
        };
        if(%{$universidad}{$kind}=~/.*$keyword.*/){
          push @universidades,$universidad;
        }
      }
    } 
  }
  return @universidades;
}

sub buildRegex{
  my $n = $_[0];
  my $general='([^\|]+)\|';
  my $ultimo = '([^\|]+)';
 
  my $str = '^';
  for(my $i=0;$i<$n;$i++){
    $str.=$general;
  }
  return $str.$ultimo;
}
