#!"c:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;


print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    
    <link rel="stylesheet" type="text/css" href="../estilos.css">
    <title>Busquedas bibliograficas de Programacion Web 1 </title>
</head>
<body>
    <div >
HTML

my $q = CGI->new;
my $busqueda= $q->param("busqueda");
my $indicador = $q->param("indicador");
my $flag;
my $contador=0;
my $encontrados=0;

    $busqueda = uc $busqueda;
    print "USTED INGRESO: ".$busqueda;

    if($indicador eq "Nombre Universidad"){
        &busqueda(1);
    } 
    elsif($indicador eq "Periodo Licenciamiento"){
        &busqueda(4);
    }elsif($indicador eq "Departamento Local"){
        &busqueda(10);
    }elsif($indicador eq "Denominacion Programa"){
        &busqueda(16);
    }else{
        print "ERROR";
    }

if(!defined($flag)){
    print "<h1>No encontrado</h1>\n";
}

print <<HTML;
 Ingrese <a href="../portada.html">aqui</a> para regresar al formulario de búsqueda
 </body>
</html>
HTML
sub busqueda{
    my ($numCasillero)=@_;
    open(IN,"../licenciadas.csv") or die "<h1>ERROR: open file</h1>\n";
        